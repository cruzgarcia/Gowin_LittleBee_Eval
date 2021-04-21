Library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.numeric_std.all;
 use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter_top IS
PORT(
    i_clock     : IN STD_LOGIC;
    i_reset_n   : IN STD_LOGIC;
    --
    o_count     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END counter_top;

ARCHITECTURE RTL OF counter_top IS

  SIGNAL r_clk_cnt    : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL r_clock_en   : STD_LOGIC;
  SIGNAL s_reset      : STD_LOGIC;

BEGIN

  s_reset   <= NOT i_reset_n;

    -- Clock divider 
  proc_clk_enable : PROCESS(s_reset, i_clock)
  BEGIN
    IF(s_reset = '1')THEN
      r_clk_cnt     <= (OTHERS => '0');
      r_clock_en    <= '0';

    ELSIF RISING_EDGE(i_clock)THEN

      r_clk_cnt     <= r_clk_cnt + '1';
      r_clock_en    <= '0';

      IF(r_clk_cnt(24) = '1')THEN
        r_clk_cnt   <= (OTHERS => '0');
        r_clock_en  <= '1';
      END IF;

    END IF;
  END PROCESS;


  proc_counter : PROCESS(s_reset, i_clock)
  BEGIN
    IF(s_reset = '1')THEN
      o_count         <= (OTHERS => '0');
    ELSIF RISING_EDGE(i_clock)THEN
      IF(r_clock_en = '1')THEN
        o_count     <= o_count + '1';
      END IF;
    END IF;
  END PROCESS;

END RTL;