library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ram_primitive is
	generic(
		DATA_LENGTH_G	: INTEGER;
		DATA_WIDTH_G	: INTEGER
		);
	port(
		clka_in			: IN STD_LOGIC;
		clkb_in			: IN STD_LOGIC;
		ena_in			: IN STD_LOGIC;
		enb_in			: IN STD_LOGIC;
		wea_in			: IN STD_LOGIC;
		web_in			: IN STD_LOGIC;
		addra_in		: IN STD_LOGIC_VECTOR(DATA_LENGTH_G - 1 DOWNTO 0);
		addrb_in		: IN STD_LOGIC_VECTOR(DATA_LENGTH_G - 1 DOWNTO 0);
		dia_in			: IN STD_LOGIC_VECTOR(DATA_WIDTH_G - 1 DOWNTO 0);
		dib_in			: IN STD_LOGIC_VECTOR(DATA_WIDTH_G - 1 DOWNTO 0);

		doa_out			: OUT STD_LOGIC_VECTOR(DATA_WIDTH_G - 1 DOWNTO 0);
		dob_out			: OUT STD_LOGIC_VECTOR(DATA_WIDTH_G - 1 DOWNTO 0)
		);
end ram_primitive;

architecture Behavioral of ram_primitive is

	type ram_type is array (2**DATA_LENGTH_G - 1 downto 0) of std_logic_vector(DATA_WIDTH_G - 1 downto 0);
	shared variable RAM : ram_type := (others => (others => '0'));

	signal doa_s : std_logic_vector(DATA_WIDTH_G - 1 downto 0) := (others => '0');
	signal dob_s : std_logic_vector(DATA_WIDTH_G - 1 downto 0) := (others => '0');

begin

	process (clka_in)
	begin
		if rising_edge(clka_in) then
			if ena_in = '1' then
				if wea_in = '1' then
					RAM(conv_integer(addra_in)) := dia_in;
				end if;
				doa_s <= RAM(conv_integer(addra_in));
			end if;
		end if;
	end process;

	process (clkb_in)
	begin
		if rising_edge(clkb_in) then
			if enb_in = '1' then
				if web_in = '1' then
					RAM(conv_integer(addrb_in)) := dib_in;
				end if;
				dob_s <= RAM(conv_integer(addrb_in));
			end if;
		end if;
	end process;

	doa_out <= doa_s;
	dob_out <= dob_s;

end Behavioral;