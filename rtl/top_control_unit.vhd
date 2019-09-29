---------------------------------------------------------------------
-- top_control_unit
-- 
--     Finite State Machine
-- |-> Wait for we -> Writing input data -> Processing microprogram ->|
-- |                                                                  |
-- |<---------------------------------------------------------------<-|
--
---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity top_control_unit is
	port (
		clk_i		: IN STD_LOGIC;
		reset_i		: IN STD_LOGIC;
		we_i		: IN STD_LOGIC;
		alu_fin_i	: IN STD_LOGIC;
		
		comm_read_o	: OUT STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
		load_en_o	: OUT STD_LOGIC := '0';
		alu_en_o	: OUT STD_LOGIC := '0';
		rdy_o		: OUT STD_LOGIC := '0'
		);
end top_control_unit;

architecture automat of top_control_unit is

	constant overflow_c : std_logic_vector(comm_read_o'range) := (0 => '0', others => '1');
	
	type top_fsm_t is (
		Initial,
		S0_Writing,
		S1_Processing,
		S2_Finish);
		
	signal fsm_s : top_fsm_t := Initial;
	signal alu_shift_s : std_logic_vector(1 downto 0) := (others => '0');
	signal command_num_s : std_logic_vector(comm_read_o'range) := (others => '0');

begin

	automat_proc : process (clk_i)
	begin
		if rising_edge(clk_i) then
			if reset_i = '0' then
				fsm_s <= Initial;
				command_num_s <= (others => '0');
				alu_shift_s <= (others => '0');
			else
				case fsm_s is
					when Initial =>
						if we_i = '1' then
							fsm_s <= S0_Writing;
						end if;
						
						command_num_s <= (others => '0');
					
					when S0_Writing =>
						if we_i = '0' then
							fsm_s <= S1_Processing;
						end if;
					
					when S1_Processing =>
						if alu_fin_i = '1' or command_num_s = overflow_c then
							fsm_s <= S2_Finish;
						end if;
						
						alu_shift_s(0) <= '1';
						command_num_s <= command_num_s + 1;
					
					when others =>		-- S2_Finish included
						fsm_s <= Initial;
						alu_shift_s(0) <= '0';
				end case;
				
				alu_shift_s(1) <= alu_shift_s(0);
			end if;
		end if;
	end process automat_proc;

	comm_read_o <= command_num_s;
	
	load_en_o <= '1' when fsm_s = S0_Writing else '0';
	alu_en_o <= alu_shift_s(1) when fsm_s = S1_Processing else '0';
	rdy_o <= '1' when fsm_s = S2_Finish else '0';

end automat;