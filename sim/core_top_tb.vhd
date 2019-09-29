library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

use work.test_pkg.all;
use work.auto_testbench_pkg.all;

entity core_top_tb is
end core_top_tb;

architecture behavior of core_top_tb is

	component core_top
		port(
			clk_i		: IN STD_LOGIC;
			reset_i		: IN STD_LOGIC;
			we_i		: IN STD_LOGIC;
			address_i	: IN STD_LOGIC_VECTOR(6 downto 0);
			in_data_i	: IN STD_LOGIC_VECTOR(20 downto 0);
			
			rdy_o		: OUT STD_LOGIC;
			error_o		: OUT STD_LOGIC;
			result_o	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
	end component;

	file input_file : text;
	file output_file : text;
	
	signal clk_i : std_logic := '0';
	signal reset_i : std_logic := '1';
	signal we_i : std_logic := '0';
	signal address_i : std_logic_vector(6 downto 0) := (others => '0');
	signal in_data_i : std_logic_vector(20 downto 0) := (others => '0');
	signal rdy_o : std_logic;
	signal error_o : std_logic;
	signal result_o : std_logic_vector(15 downto 0);
	
	-- Automatic Testbench
	signal clr_s : std_logic := '0';
	signal command_ram_s : command_RAM_t := (others => (others => '0'));
	signal data_ram_s : data_RAM_t := (others => (others => '0'));
	signal result_data_s, auto_tb_result_s : std_logic_vector(16 downto 0) := (others => '0');
	signal testbench_valid_b : boolean := false;
	signal check_result_b : boolean := false;

	-- Clock period definitions
	constant clk_i_period : time := 5 ns;
	
	type string_a is array(1 to 5) of string(r_file1_c'range);
	constant read_files_c : string_a := (r_file1_c, r_file2_c, r_file3_c, r_file4_c, r_file5_c);
	constant write_files_c : string_a := (w_file1_c, w_file2_c, w_file3_c, w_file4_c, w_file5_c);
	
begin

	uut: core_top PORT MAP (
		clk_i		=> clk_i,
		reset_i		=> reset_i,
		we_i		=> we_i,
		address_i	=> address_i,
		in_data_i	=> in_data_i,
		
		rdy_o		=> rdy_o,
		error_o		=> error_o,
		result_o	=> result_o
		);

	result_data_s <= error_o & result_o;

	-- Clock process definitions
	clk_i_process : process
	begin
		clk_i <= '1';
		wait for clk_i_period/2;
		clk_i <= '0';
		wait for clk_i_period/2;
	end process;
	
	read_file_proc : process
		variable count_v : integer := 0;
		variable inline_v, outline_v : line;
		variable in_data_v : std_logic_vector(20 downto 0);
	begin
		wait until reset_i = '1';
		wait until rising_edge(clk_i);
	
		for i in 1 to 5 loop
			file_open(input_file, read_files_c(i), read_mode);
			file_open(output_file, write_files_c(i), write_mode);
		
			we_i <= '1';
			while not endfile(input_file) loop
				readline(input_file, inline_v);
				read (inline_v, in_data_v);
				
				in_data_i <= in_data_v;
				address_i <= std_logic_vector(to_unsigned(count_v, 7));
				
				wait for 5 ns;

				if address_i(6) = '0' then
					command_ram_s(to_integer(unsigned(address_i(5 downto 0)))) <= in_data_i;
				else data_ram_s(to_integer(unsigned(address_i(5 downto 0)))) <= in_data_i(15 downto 0);
				end if;

				count_v := count_v + 1;
			end loop;
			we_i <= '0';

			wait until rising_edge(rdy_o);
			write(outline_v, result_data_s);
			writeline(output_file, outline_v);
			
			auto_tb_result_s <= decode_f(command_ram_s, data_ram_s);
			wait until rising_edge(clk_i);

			clr_s <= '1';
			command_ram_s <= (others => (others => '0'));
			data_ram_s <= (others => (others => '0'));
			wait until rising_edge(clk_i);

			clr_s <= '0';
			file_close(input_file);
			file_close(output_file);

			-- Assert
			assert check_result_b
				report "         Test #" & integer'image(i) &
					" finish. Test pass:" & boolean'image(testbench_valid_b)
				severity warning;
		end loop;
		
		wait;
	end process;

	-- Automatic Testbench
	wr_data : process(clk_i)
	begin
		if rising_edge(clk_i) then
			if rdy_o = '1' then
				testbench_valid_b <= (result_data_s = auto_tb_result_s);
			elsif clr_s = '1' then
				testbench_valid_b <= false;
			end if;

			check_result_b <= rdy_o = '1';
		end if;
	end process;

	stim_proc : process
	begin
		reset_i <= '0';
		wait for 100 ns;

		reset_i <= '1';
		
		wait;
	end process;
end;