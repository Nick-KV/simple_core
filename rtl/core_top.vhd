---------------------------------------------------------------------
-- core_top
-- Initialisation address structure
--  Code(1)/Data(0)    RAM Address
-- ----------------------------------
-- |      6        |   5 downto 0   |
-- ----------------------------------
-- 
-- Code structure
--   Code   RD1 Addr  RD2 Addr  WR Addr
-- --------------------------------------
-- | 20:18 | 17 : 12 | 11 : 6  | 5 : 0  |
-- --------------------------------------
---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity core_top is
	port (
		clk_i		: IN STD_LOGIC;
		reset_i		: IN STD_LOGIC;
		we_i		: IN STD_LOGIC;
		address_i	: IN STD_LOGIC_VECTOR(6 downto 0);
		in_data_i	: IN STD_LOGIC_VECTOR(20 downto 0);
		
		rdy_o		: OUT STD_LOGIC := '0';
		error_o		: OUT STD_LOGIC := '0';
		result_o	: OUT STD_LOGIC_VECTOR(15 downto 0) := (others => '0')
		);
end core_top;

architecture rtl of core_top is
	
	constant ram_width_c : natural := 6;	-- ram address width (2**6 = 64)
	constant code_length_c : natural := 21;
	constant data_length_c : natural := 16;
	
	constant ram_type_bit : natural := 6;
	subtype ram_adds_rng is natural range 5 downto 0;
	
	subtype code_length_rng is natural range code_length_c - 1 downto 0;
	subtype data_length_rng is natural range data_length_c - 1 downto 0;
	
	subtype code_rng is natural range 20 downto 18;
	subtype rd1_adds_rng is natural range 17 downto 12;
	subtype rd2_adds_rng is natural range 11 downto 6;
	subtype wr_adds_rng is natural range 5 downto 0;
	
	type adds_ram_shift_t is array(0 to 2) of std_logic_vector(ram_adds_rng);
	type adds_ram_t is array(0 to 1) of std_logic_vector(ram_adds_rng);

	signal code_en_s, data_en_s : std_logic := '0';
	signal data_wea_s, data_web_s : std_logic := '0';
	signal load_ram_adds_s : std_logic_vector(ram_adds_rng) := (others => '0');
	signal read_code_adds_s : std_logic_vector(ram_adds_rng) := (others => '0');
	signal read_data1_adds_s, read_data2_adds_s : std_logic_vector(ram_adds_rng) := (others => '0');
	signal raddr_data_mux_s : adds_ram_t := (others => (others => '0'));
	signal data_b_ram_adds_s : adds_ram_shift_t := (others => (others => '0'));
	
	signal load_code_s : std_logic_vector(code_length_rng) := (others => '0');
	signal read_code_s : std_logic_vector(code_length_rng) := (others => '0');
	signal load_data_s : std_logic_vector(data_length_rng) := (others => '0');
	signal write_data_s : std_logic_vector(data_length_rng) := (others => '0');
	signal read_data1_s, read_data2_s : std_logic_vector(data_length_rng) := (others => '0');
	
	signal alu_fin_s, alu_en_s : std_logic := '0';
	signal loading_data_s : std_logic := '0';
	signal error_s : std_logic := '0';
	
	signal code_s : std_logic_vector(2 downto 0) := (others => '0');

begin

	code_en_s <= not address_i(ram_type_bit);		-- enable write code
	data_en_s <= address_i(ram_type_bit);			-- enable write data
	load_ram_adds_s <= address_i(ram_adds_rng);		-- code/data addr
	
	load_code_s <= in_data_i(code_length_rng);
	load_data_s <= in_data_i(data_length_rng);
	
	read_data1_adds_s <= read_code_s(rd1_adds_rng);
	read_data2_adds_s <= read_code_s(rd2_adds_rng);
	data_b_ram_adds_s(0) <= read_code_s(wr_adds_rng);

	top_control_unit_inst: entity work.top_control_unit
		port map(
			clk_i		=> clk_i,
			reset_i		=> reset_i,
			we_i		=> we_i,
			alu_fin_i	=> alu_fin_s,
			
			comm_read_o	=> read_code_adds_s,
			load_en_o	=> loading_data_s,
			alu_en_o	=> alu_en_s,
			rdy_o		=> rdy_o
			);

	alu_comb: entity work.alu_comb
		port map(
			clk_i		=> clk_i,
			reset_i		=> reset_i,
			alu_en_i	=> alu_en_s,
			code_i		=> code_s,
			data1_i		=> read_data1_s,
			data2_i		=> read_data2_s,
			rd1_adds_i	=> read_data1_adds_s,
			rd2_adds_i	=> read_data2_adds_s,
			wr_adds_i	=> data_b_ram_adds_s(2),
			
			wr_en_o		=> data_web_s,
			data_o		=> write_data_s,
			error_o		=> error_s,
			alu_fin_o	=> alu_fin_s
			);

	command_RAM_inst: entity work.ram_primitive
		generic map(
			DATA_LENGTH_G	=> ram_width_c,
			DATA_WIDTH_G	=> code_length_c
			)
		port map(
			clka_in		=> clk_i,
			clkb_in		=> clk_i,
			
			ena_in		=> code_en_s,
			enb_in		=> '1',
			wea_in		=> we_i,
			web_in		=> '0',
			addra_in	=> load_ram_adds_s,
			addrb_in	=> read_code_adds_s,
			dia_in		=> load_code_s,
			dib_in		=> (others => '0'),
			
			doa_out		=> open,
			dob_out		=> read_code_s
			);

	data_wea_s <= data_en_s and we_i when loading_data_s = '1'
		else '0';
	
	raddr_data_mux_s(0) <= load_ram_adds_s when loading_data_s = '1' else
		read_data1_adds_s;

	raddr_data_mux_s(1) <= load_ram_adds_s when loading_data_s = '1' else
		read_data2_adds_s;

	data1_RAM_inst: entity work.ram_primitive
		generic map(
			DATA_LENGTH_G	=> ram_width_c,
			DATA_WIDTH_G	=> data_length_c
			)
		port map(
			clka_in		=> clk_i,
			clkb_in		=> clk_i,
			
			ena_in		=> '1',
			enb_in		=> '1',
			wea_in		=> data_wea_s,
			web_in		=> data_web_s,
			addra_in	=> raddr_data_mux_s(0),
			addrb_in	=> data_b_ram_adds_s(2),
			dia_in		=> load_data_s,
			dib_in		=> write_data_s,
			
			doa_out		=> read_data1_s,
			dob_out		=> open
			);

	data2_RAM_inst: entity work.ram_primitive
		generic map(
			DATA_LENGTH_G	=> ram_width_c,
			DATA_WIDTH_G	=> data_length_c
			)
		port map(
			clka_in		=> clk_i,
			clkb_in		=> clk_i,
			
			ena_in		=> '1',
			enb_in		=> '1',
			wea_in		=> data_wea_s,
			web_in		=> data_web_s,
			addra_in	=> raddr_data_mux_s(1),
			addrb_in	=> data_b_ram_adds_s(2),
			dia_in		=> load_data_s,
			dib_in		=> write_data_s,
			
			doa_out		=> read_data2_s,
			dob_out		=> open
			);
	
	trig_proc : process (clk_i)
	begin
		if rising_edge(clk_i) then
			if reset_i = '0' then
				code_s <= (others => '0');
				data_b_ram_adds_s(1 to 2) <= (others => (others => '0'));
				error_o <= '0';
			else
				code_s <= read_code_s(code_rng);
				data_b_ram_adds_s(1 to 2) <= data_b_ram_adds_s(0 to 1);
				error_o <= error_s;
			end if;
		end if;
	end process trig_proc;

	result_o <= write_data_s;

end rtl;