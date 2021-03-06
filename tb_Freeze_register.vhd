library ieee; 
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity tb_Freeze_Register is
end tb_Freeze_Register;

architecture behaviour of tb_Freeze_Register is 

component Freeze_Register is 
port (
	disable_n: in std_logic;
	clk : in std_logic; 
	d : in std_logic_vector (15 downto 0);
	sswitch_in : in std_logic_vector (1 downto 0); 
	q : out std_logic_vector (15 downto 0); 
	sswitch_out : out std_logic_vector (1 downto 0); 
	reset_n : in std_logic
);
end component;


signal clk, disable_n, reset_n: std_logic; 
signal d,q  : std_logic_vector(15 downto 0);
signal sswitch_in,sswitch_out: std_logic_vector(1 downto 0);
constant clk_period : time := 20 ns; 


begin 

UUT : Freeze_Register
port map (

	clk =>clk, 
	disable_n => disable_n, 
	d => d, 
	sswitch_in => sswitch_in,
	q => q, 
	sswitch_out => sswitch_out,
	reset_n => reset_n

); 


clk_process: process is 
	variable i : integer := 0;
		
	begin 
	
	while i < 12 loop
		clk <= '0'; wait for clk_period/2; 
		clk <= '1'; wait for clk_period/2; 
		i:= i+1;
	end loop; 
	wait; 
	
	end process; 
	
stim_process: process 
	begin 
	
	sswitch_in <= "00"; reset_n <= '1'; d <= X"0000"; disable_n <= '1';  wait for 2*clk_period; 
	d <= X"00FF"; wait for 2*clk_period; 
	disable_n <= '0'; wait for clk_period; 
	sswitch_in <= "10"; d <= X"0111"; wait for clk_period; 
	sswitch_in <= "11"; d <= X"FF00"; wait for clk_period; 
	disable_n <= '1'; wait for clk_period; 
	reset_n <= '0'; d <= X"F0F0"; wait for clk_period; 
	sswitch_in <= "10"; d <= X"0F0F"; wait for clk_period; 
	reset_n <= '1'; wait for 2*clk_period; 
	
	wait; 
	end process; 


end behaviour; 