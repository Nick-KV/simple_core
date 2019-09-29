library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

package auto_testbench_pkg is

	type command_RAM_t is array (0 to 63) of std_logic_vector(20 downto 0);
	type data_RAM_t is array (0 to 63) of std_logic_vector(15 downto 0);
	
    function decode_f(command_ram : command_RAM_t; data_ram : data_RAM_t) return std_logic_vector;
	
end auto_testbench_pkg;

package body auto_testbench_pkg is

    function decode_f(command_ram : command_RAM_t; data_ram : data_RAM_t)
	return std_logic_vector is	
		variable temp_ram : data_RAM_t := data_ram;
		variable code_v : integer;
		variable raddr1_v, raddr2_v, waddr_v : integer;
		variable data1_v, data2_v, data_temp_v : integer;
		variable error_v : std_logic := '0';
		variable temp_v : std_logic_vector(15 downto 0);
		variable result_v : std_logic_vector(16 downto 0);
    begin
		for i in 0 to 63 loop
			code_v := to_integer(unsigned(command_ram(i)(20 downto 18)));
			raddr1_v := to_integer(unsigned(command_ram(i)(17 downto 12)));
			raddr2_v := to_integer(unsigned(command_ram(i)(11 downto 6)));
			waddr_v := to_integer(unsigned(command_ram(i)(5 downto 0)));
			
			data1_v := to_integer(signed(temp_ram(raddr1_v)));
			data2_v := to_integer(signed(temp_ram(raddr2_v)));
			
			case code_v is
				when 1 => data_temp_v := data1_v + data2_v;
					temp_v := std_logic_vector(to_signed(data_temp_v, 16));
					if ((data_temp_v > 32767) or (data_temp_v < -32768)) then
						error_v := '1';
					end if;
				when 2 => data_temp_v := data1_v - data2_v;
					temp_v := std_logic_vector(to_signed(data_temp_v, 16));
					if ((data_temp_v > 32767) or (data_temp_v < -32768)) then
						error_v := '1';
					end if;
				when 3 => data_temp_v := data1_v * data2_v;
					temp_v := std_logic_vector(to_signed(data_temp_v, 16));
					if ((data_temp_v > 32767) or (data_temp_v < -32768)) then
						error_v := '1';
					end if;
				when 7 => exit;
				when others => null;
			end case;
			
			temp_ram(waddr_v) := temp_v;
			result_v := error_v & temp_v;
			
		end loop;
		return result_v;
    end function;

end auto_testbench_pkg;