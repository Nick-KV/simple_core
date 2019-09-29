---------------------------------------------------------------------
-- alu_comb
-- 
-- Arithmetic Logical Unit
-- Coding:
-- Adding - 001
-- Substracting - 010
-- Multiplication - 011
-- NOP - 000
-- Finish - 111
-- 
---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_signed.all;

entity alu_comb is
	port (
		clk_i		: IN STD_LOGIC;
		reset_i		: IN STD_LOGIC;
		alu_en_i	: IN STD_LOGIC;
		code_i		: IN STD_LOGIC_VECTOR(2 downto 0);
		data1_i		: IN STD_LOGIC_VECTOR(15 downto 0);
		data2_i		: IN STD_LOGIC_VECTOR(15 downto 0);
		rd1_adds_i	: IN STD_LOGIC_VECTOR(5 downto 0);
		rd2_adds_i	: IN STD_LOGIC_VECTOR(5 downto 0);
		wr_adds_i	: IN STD_LOGIC_VECTOR(5 downto 0);
		
		wr_en_o		: OUT STD_LOGIC;
		data_o		: OUT STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
		error_o		: OUT STD_LOGIC;
		alu_fin_o	: OUT STD_LOGIC
		);
end alu_comb;

architecture behavioral of alu_comb is

	constant acc_c : std_logic_vector(data1_i'range) := (others => '0');
	constant zeros_c : signed(15 downto 0) := (others => '0');
	constant ones_c : signed(15 downto 0) := (others => '1');
	
	constant nop_c : std_logic_vector(code_i'range) := "000";
	constant add_c : std_logic_vector(code_i'range) := "001";
	constant sub_c : std_logic_vector(code_i'range) := "010";
	constant mul_c : std_logic_vector(code_i'range) := "011";
	constant fin_c : std_logic_vector(code_i'range) := "111";
	
	signal wr_en_s : std_logic_vector(1 downto 0) := (others => '0');
	signal error_s : std_logic := '0';
	signal error_add_s, error_sub_s, error_mul_s : std_logic := '0';
	signal data1_in_s, data2_in_s : signed(15 downto 0) := (others => '0');
	signal data_add_s, data_sub_s, data_out_s : signed(15 downto 0) := (others => '0');
	signal data_out_acc_s : signed(15 downto 0) := (others => '0');
	signal data_mul_s : signed(31 downto 0) := (others => '0');
	alias high_mul_s : signed(15 downto 0) is data_mul_s(31 downto 16);
	
	type adds_a is array (0 to 1) of std_logic_vector(5 downto 0);
	signal rd1_adds_s, rd2_adds_s : std_logic_vector(5 downto 0) := (others => '0');
	signal wr_adds_s : std_logic_vector(5 downto 0) := (others => '0');

begin
	data1_in_s <= signed(data1_i) when wr_en_s(0) = '0' or (rd1_adds_s /= wr_adds_i and rd1_adds_s /= wr_adds_s)
		else data_out_s when rd1_adds_s = wr_adds_i
		else data_out_acc_s when rd1_adds_s = wr_adds_s
		else (others => '0');
	data2_in_s <= signed(data2_i) when wr_en_s(0) = '0' or (rd2_adds_s /= wr_adds_i and rd2_adds_s /= wr_adds_s)
		else data_out_s when rd2_adds_s = wr_adds_i
		else data_out_acc_s when rd2_adds_s = wr_adds_s
		else (others => '0');
	
	data_o <= std_logic_vector(data_out_s);
	wr_en_o <= wr_en_s(0);
	
	-- Adding
	data_add_s <= data1_in_s + data2_in_s;
	error_add_s <= data_add_s(15) when (data1_in_s(15) =  '0' and data2_in_s(15) = '0')
		else not data_add_s(15) when (data1_in_s(15) =  '1' and data2_in_s(15) = '1')
		else '0';
	-- Substracting
	data_sub_s <= data1_in_s - data2_in_s;
	error_sub_s <= data_add_s(15) when (data1_in_s(15) =  '0' and data2_in_s(15) = '1')
		else not data_add_s(15) when (data1_in_s(15) =  '0' and data2_in_s(15) = '1')
		else '0';
	-- Multiplication
	data_mul_s <= data1_in_s * data2_in_s;
	error_mul_s <= '0' when (data1_in_s(15) xor data2_in_s(15)) = '1' and high_mul_s = ones_c else
		'0' when (data1_in_s(15) xor data2_in_s(15)) = '0' and high_mul_s = zeros_c else
		'1';
	
	main_proc : process (clk_i)
	begin
		if rising_edge(clk_i) then
			if reset_i = '0' then
				wr_en_s <= (others => '0');
				data_out_s <= (others => '0');
				data_out_acc_s <= (others => '0');
				error_s <= '0';

				rd1_adds_s <= (others => '0');
				rd2_adds_s <= (others => '0');
				wr_adds_s <= (others => '0');
			else
				if alu_en_i = '1' then
					case code_i is
						when add_c => data_out_s <= data_add_s;
							error_s <= error_s or error_add_s;
						when sub_c => data_out_s <= data_sub_s;
							error_s <= error_s or error_sub_s;
						when mul_c => data_out_s <= data_mul_s(data_out_s'range);
							error_s <= error_s or error_mul_s;
						when others => null;
					end case;
					
					case code_i is
						when add_c | sub_c | mul_c => wr_en_s <= wr_en_s(0) & '1';
						when others => wr_en_s <= wr_en_s(0) & '0';
					end case;
				else
					wr_en_s <= (others => '0');
					data_out_s <= (others => '0');
					error_s <= '0';
				end if;
				
				data_out_acc_s <= data_out_s;
				
				rd1_adds_s <= rd1_adds_i;
				rd2_adds_s <= rd2_adds_i;
				wr_adds_s <= wr_adds_i;
			end if;
		end if;
	end process main_proc;
	
	error_o <= error_s when code_i = fin_c else '0';
	alu_fin_o <= '1' when code_i = fin_c else '0';

end behavioral;