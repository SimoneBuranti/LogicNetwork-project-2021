library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity project_reti_logiche is
     port (
            i_clk: in STD_LOGIC;
            i_rst: in STD_LOGIC;
            i_start: in STD_LOGIC;
            i_data  : in STD_LOGIC_VECTOR(7 downto 0);
            o_address : out STD_LOGIC_VECTOR(15 downto 0);
            o_en : out STD_LOGIC;
            o_done :out STD_LOGIC;
            o_we      : out STD_LOGIC;
            o_data    : out STD_LOGIC_VECTOR (7 downto 0));
end project_reti_logiche;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;


entity datapath is
port( 
    i_clk : in STD_LOGIC;
    i_rst : in STD_LOGIC;
    i_start : in STD_LOGIC;
    i_data : in STD_LOGIC_VECTOR (7 downto 0);
    o_address : out STD_LOGIC_VECTOR (15 downto 0);
    o_data : out STD_LOGIC_VECTOR (7 downto 0);
    sel12: in STD_LOGIC_VECTOR(1 downto 0);
    sel_adda: in STD_LOGIC;
    sel_ps: in STD_LOGIC;
    sel_mm: in STD_LOGIC;
    sel_vw: in STD_LOGIC;
    sel_rv: in STD_LOGIC;
    sel_f: in STD_LOGIC;
    sel_rig: in STD_LOGIC;
    sel_col: in STD_LOGIC;
    sel_ac: in STD_LOGIC;
    load_data : in STD_LOGIC;
    load_rig: in STD_LOGIC;
    load_col: in STD_LOGIC;
    load_rc: in STD_LOGIC;
    load_cc: in STD_LOGIC;
    load_ad: in STD_LOGIC;
    load_ad2: in STD_LOGIC;
    load_p: in STD_LOGIC;
    load_R1: in STD_LOGIC;
    load_R2: in STD_LOGIC;
    load_R3: in STD_LOGIC;
    load_max: in STD_LOGIC;
    load_min: in STD_LOGIC;
    load_id: in STD_LOGIC;
    load_shift: in STD_LOGIC;
    load_delta: in STD_LOGIC;
    load_fin: in STD_LOGIC;
    sig_zero1:out STD_LOGIC; 
    sig_zero2:out STD_LOGIC; 
    sig_stopsum: out STD_LOGIC; 
    sig_stopmm2: out STD_LOGIC;
    sig_stoplett: out STD_LOGIC 
);
end datapath;

architecture Behavioral of project_reti_logiche is
component datapath is 
port(    
    i_clk : in STD_LOGIC;
    i_rst : in STD_LOGIC;
    i_start : in STD_LOGIC;
    i_data : in STD_LOGIC_VECTOR (7 downto 0);
    o_address : out STD_LOGIC_VECTOR (15 downto 0);
    o_data : out STD_LOGIC_VECTOR (7 downto 0);
    sel12:  in STD_LOGIC_VECTOR(1 downto 0);
    sel_adda: in  STD_LOGIC;
    sel_ps:  in  STD_LOGIC;
    sel_mm: in STD_LOGIC;
    sel_vw: in STD_LOGIC;
    sel_rv: in STD_LOGIC;
    sel_f: in STD_LOGIC;
    sel_rig: in STD_LOGIC;
    sel_col: in STD_LOGIC;
    sel_ac: in STD_LOGIC;
    load_data : in STD_LOGIC;
    load_rig: in STD_LOGIC;
    load_col: in STD_LOGIC;
    load_rc: in STD_LOGIC;
    load_cc: in STD_LOGIC;
    load_ad: in STD_LOGIC;
    load_ad2: in STD_LOGIC;
    load_p: in STD_LOGIC;
    load_R1: in STD_LOGIC;
    load_R2: in STD_LOGIC;
    load_R3: in STD_LOGIC;
    load_max: in STD_LOGIC;
    load_min: in STD_LOGIC;
    load_id: in STD_LOGIC;
    load_shift: in STD_LOGIC;
    load_delta: in STD_LOGIC;
    load_fin: in STD_LOGIC;
    sig_zero1:out STD_LOGIC;
    sig_zero2:out STD_LOGIC;
    sig_stopsum: out STD_LOGIC; --asincrono
    sig_stopmm2: out STD_LOGIC; --asincrono
    sig_stoplett: out STD_LOGIC --asincrono
    );
end component;

signal sel12: STD_LOGIC_VECTOR(1 downto 0);
signal sel_adda: STD_LOGIC;
signal sel_ps:  STD_LOGIC;
signal sel_mm:STD_LOGIC;
signal sel_vw:STD_LOGIC;
signal sel_rv:STD_LOGIC;
signal sel_f:STD_LOGIC;
signal sel_rig:STD_LOGIC;
signal sel_col:STD_LOGIC;
signal sel_ac:STD_LOGIC;

signal load_data :STD_LOGIC;
signal load_rig:STD_LOGIC;
signal load_col:STD_LOGIC;
signal load_rc:STD_LOGIC;
signal load_cc:STD_LOGIC;
signal load_ad:STD_LOGIC;
signal load_ad2:STD_LOGIC;
signal load_p:STD_LOGIC;
signal load_R1:STD_LOGIC;
signal load_R2:STD_LOGIC;
signal load_R3:STD_LOGIC;
signal load_max:STD_LOGIC;
signal load_min:STD_LOGIC;
signal load_id:STD_LOGIC;
signal load_shift:STD_LOGIC;
signal load_delta:STD_LOGIC;
signal load_fin:STD_LOGIC;

signal sig_zero1:STD_LOGIC; --asincrono
signal sig_zero2:STD_LOGIC; --asincrono
signal sig_stopsum:STD_LOGIC; --asincrono
signal sig_stopmm2:STD_LOGIC; --asincrono
signal sig_stoplett:STD_LOGIC; --asincrono

type S is(S0,S1,S2,S3,S4,S5,S6,S6a,S6b,S7a,S7b,S8a,S8b,S9a,S9b,S10,S11,S12,S13,s14,S15,S16,S17,S18,DONE,SOTTRAGGO,SOMMO);
signal curr_state, next_state:S;

begin
    DATAPATH0: datapath port map(
        i_clk,
        i_rst,
        i_start,
        i_data,
        o_address,
        o_data,
        sel12,
        sel_adda,
        sel_ps,
        sel_mm,
        sel_vw,
        sel_rv,
        sel_f,
        sel_rig,
        sel_col,
        sel_ac,
        load_data,
        load_rig,
        load_col,
        load_rc,
        load_cc,
        load_ad,
        load_ad2,
        load_p,
        load_R1,
        load_R2,
        load_R3,
        load_max,
        load_min,
        load_id,
        load_shift,
        load_delta,
        load_fin,
        sig_zero1,
        sig_zero2,
        sig_stopsum,
        sig_stopmm2,
        sig_stoplett      
    );
    
    
    process(i_clk, i_rst)
    begin
        if(i_rst='1')then 
            curr_state<=S0;
        elsif rising_edge(i_clk) then
            curr_state<=next_state;
        end if;
    end process;
    
    
    process(curr_state, i_clk,i_start,sig_stoplett,sig_stopsum,sig_zero1,sig_zero2,sig_stopmm2)
    begin
        next_state<=curr_state;
        case curr_state is
        
                when S0 =>
                    if i_start = '1' then
                        next_state <= S1;
                    end if;
                    
                when S1=>
                    next_state <= S2;
                    
                when S2 =>
                    if sig_zero1= '1' then
                        next_state <= DONE;
                    else
                        next_state <= S3;
                    end if;
                        
                when S3 =>
                    if sig_zero2= '1' then
                        next_state <= DONE;
                    else
                        next_state <= S4;
                    end if;
                    
                when S4 =>
                    next_state <= SOTTRAGGO ;
                    
                when SOTTRAGGO =>
                     if sig_stopsum= '1' then
                           next_state <= S5;
                      else
                          next_state <= SOMMO;
                   end if;
                   
                when SOMMO =>
                    next_state <= SOTTRAGGO ;
                    
                when S5 =>
                    next_state <= S6;
                    
                when S6=>	
                    if sig_stopmm2= '1'   then
                        next_state <= S6a;
                    else 
                        next_state <= S6b;
                    end if;
                    
                    
                when S6b=>
                    next_state <= S7b;
                
                when S7b=>
                    next_state <= S8b;
                
                when S8b=>
                    next_state <= S9b;
                
                when S9b=>
                    next_state <= S6;
                
                when S6a=>
                    next_state <= S7a;
                
                when S7a=>
                    next_state <= S8a;
                
                when S8a=>
                    next_state <= S9a;
                
                when S9a=>
                    next_state <= S10;
             
                when S10 =>
                    next_state <= S11;
                    
                when S11=>
                    next_state <= S12;
                    
                when S12=>
                    if sig_stoplett= '1' then
                        next_state <= DONE;
                    else 
                        next_state <= S13;
                    end if;
                    
                when S13 =>
                        next_state <= S14;
                        
                when S14 =>
                        next_state <= S15;
                        
                when S15 =>
                    next_state <= S16;
                    
                when S16=>
                    next_state <= S17;
                    
                when S17=>
                     next_state <= S12;
                     
                when DONE=>
                    if i_start= '1' then
                        next_state <= DONE;
                    else 
                        next_state <= S18;
                    end if;
                
                when S18=>
                    if i_start= '0' then
                        next_state <= S18;
                    else 
                        next_state <= S0;
                    end if;
                    
        end case;
    end process;
    
    
    process(curr_state)
    begin
        o_en <='0';
        o_done <='0';
        o_we <='0';
        sel12<="11";
        sel_adda<='0';
        sel_ps<='0';
        sel_mm<='0';
        sel_vw<='0';
        sel_rv<='0';
        sel_f<='0';
        sel_rig<='0';
        sel_col<='0';
        sel_ac<='0';
        
        load_data<='0';
        load_rig<='0';
        load_col<='0';
        load_rc<='0';
        load_cc<='0';
        load_ad<='0';
        load_ad2<='0';
        load_p<='0';
        load_R1<='0';
        load_R2<='0';
        load_R3<='0';
        load_max<='0';
        load_min<='0';
        load_id<='0';
        load_shift<='0';
        load_delta<='0';
        load_fin<='0';
        
        
        case curr_state is
        
            when S0=>
            
            when S1=>
                o_en <='1';
                sel12<="00";
                sel_adda<='0';
                sel_ps<='0';
            
            
            when S2=>
                o_en <='1';
                sel12<="01";
                sel_adda<='0';
                sel_ps<='0';
                load_col<='1';
            
            
            when S3=>
                o_en <='1';
                sel_ps<='1';
                load_col<='0';
                load_rig<='1';
                sel12<="01";
                sel_adda<='0';
                load_col<='0';
            
            
            when S4=>
                o_en <='1';
                sel12<="01";
                load_rig<='1';
                sel_rig<='0';
                sel_col<='0';
                load_cc<='0';
                sel_f<='0';
                load_rc<='1';
            
            when SOTTRAGGO =>
                o_en<='1';
                sel12<="01";
                sel_rig<='1';
                sel_col<='1';
                load_cc<='0';
                sel_f<='0';
                load_rc<='1';
            
            when SOMMO =>
                sel12<="01";
                sel_col<='1';
                load_cc<='1';
                sel_f<='0';
                load_rc<='0';
            
            when S5=>
                load_cc<='0';
                sel_f<='1';
                sel12<="01";
                load_R1<='1';
                load_R2<='1';
                load_R3<='1';
                sel_mm<='1';
                sel_f<='1';
            
            when S6=>
                load_R1<='0';
                load_ad<='0';
                sel_mm<='0';
                sel_rv<='0';
                sel12<="01";
                sel_ac<='0';
                o_we<='0';
                o_en<='0';
            
            when S6b=>
                load_R1<='1';
                load_ad<='0';
                sel_mm<='0';
                sel_rv<='0';
                sel12<="01";
                sel_ac<='0';
                o_we<='0';
                o_en<='0';
            
            
            
            when S7b=>
                load_R1<='0';
                o_en<='0';
                o_we<='0';
                sel_rv<='0';
                load_ad<='1';
                sel12<="11";
                load_data<='0';
                sel_adda<='1';
                sel_mm<='0';
            
            when S8b=>
                load_data<='1';
                o_en<='1';
                o_we<='0';
                sel12<="11";
                sel_adda<='1';
                load_ad<='0';
                load_R1<='0';
            
            when S9b=>
                sel12<="11";
                load_data<='0';
                o_en<='0';
                o_we<='0';
                sel_adda<='1';
                load_ad<='0';
                load_R1<='0';
                load_min<='1';
                load_max<='1';
            
            when S6a=>
                load_R1<='1';
                load_ad<='0';
                sel_mm<='0';
                sel_rv<='0';
                sel12<="11";
                sel_ac<='0';
                o_we<='0';
                o_en<='0';
            
            when S7a=>
                o_en<='0';
                o_we<='0';
                sel_rv<='0';
                load_ad<='1';
                sel12<="11";
                load_data<='0';
                sel_adda<='1';
            
            when S8a=>
                load_data<='1';
                o_en<='1';
                o_we<='0';
                sel_adda<='1';
                load_ad<='0';
                sel12<="11";
            
            
            when S9a=>
                sel12<="11";
                load_data<='1';
                o_en<='1';
                o_we<='0';
                sel_adda<='1';
                load_ad<='0';
                load_R1<='0';
                load_min<='1';
                load_max<='1';
            
            
            when S10=>
                sel12<="11";
                o_en<='0';
                o_we<='0';
                load_delta<='1';
                sel_adda<='1';
                load_min<='0';
                load_max<='0';
            
            when S11=>
                sel12<="11";
                o_en<='0';
                o_we<='0';
                load_delta<='0';
                load_shift<='1';
                sel_adda<='1';
                load_max<='0';
            
            when S12=>
                o_en<='0';
                o_we<='0';
                sel_rv<='1';
                sel12<="11";
                load_ad<='1';
                sel_adda<='1';
                sel_vw<='1';
                load_ad2<='0';
                sel_ac<='1';
                load_shift <= '0';
            
            when S13=>
                o_en<='1';
                o_we<='0';
                sel_rv<='1';
                sel12<="11";
                load_ad<='0';
                sel_adda<='1';
                sel_vw<='1';
                load_ad2<='0';
                sel_ac<='1';
                load_data<='0';
                load_ad<='0';
                
                
            when S14=>
                o_en<='1';
                o_we<='0';
                sel_rv<='1';
                sel12<="11";
                load_ad<='0';
                sel_adda<='1';
                sel_vw<='1';
                load_ad2<='0';
                sel_ac<='1';
                load_data<='1';
                load_ad<='0';
                
                
            when S15=>
                o_en<='0';
                o_we<='0';
                sel_rv<='1';
                sel12<="11";
                load_ad<='0';
                sel_adda<='1';
                sel_vw<='1';
                load_ad2<='0';
                sel_ac<='1';
                load_data<='0';
                load_ad<='0';
                load_fin<='1';
            
            
            when S16=>
                o_en<='0';
                o_we<='0';
                sel_rv<='1';
                sel12<="11";
                load_ad<='1';
                sel_adda<='1';
                sel_vw<='0';
                load_ad2<='1';
                sel_ac<='1';
                load_data<='0';
                load_ad<='1';
                load_id<='1';
                load_fin<='0';
            
            
            when S17=>
                o_en<='1';
                o_we<='1';
                load_id <='0';
                load_ad2 <='0';
                load_ad <='0';
                sel12<="11";
            
            when DONE=>
                o_done<='1';
            
            when S18=>
                o_done<='0';
    
        end case;
    end process ;
    
    
end Behavioral;


architecture Behavioral of datapath is
    signal r_datai : STD_LOGIC_VECTOR (7 downto 0);
    signal r_datao : STD_LOGIC_VECTOR (7 downto 0);
    signal compa: STD_LOGIC_VECTOR (7 downto 0);
    signal mini : STD_LOGIC_VECTOR (7 downto 0);
    signal maxi : STD_LOGIC_VECTOR (7 downto 0);
    signal max : STD_LOGIC_VECTOR (7 downto 0);
    signal min : STD_LOGIC_VECTOR (7 downto 0);
    signal deltai : STD_LOGIC_VECTOR (7 downto 0);
    signal deltao: STD_LOGIC_VECTOR (7 downto 0);
    signal amp: STD_LOGIC_VECTOR (7 downto 0);
    signal encoi: STD_LOGIC_VECTOR (7 downto 0);
    
    signal shifti : STD_LOGIC_VECTOR (3 downto 0);
    signal shifto: STD_LOGIC_VECTOR (3 downto 0);
    signal minus: STD_LOGIC_VECTOR (7 downto 0);
    signal risi : STD_LOGIC_VECTOR (15 downto 0);
    signal riso : STD_LOGIC_VECTOR (15 downto 0);
    signal addai: STD_LOGIC_VECTOR (7 downto 0);
    signal rigai: STD_LOGIC_VECTOR (7 downto 0);
    signal coloi: STD_LOGIC_VECTOR (7 downto 0);
    signal rigao: STD_LOGIC_VECTOR (7 downto 0);
    signal colrs: STD_LOGIC_VECTOR (15 downto 0);
    signal coloexit: STD_LOGIC_VECTOR (7 downto 0);
    signal rci: STD_LOGIC_VECTOR (7 downto 0);
    signal rco: STD_LOGIC_VECTOR (7 downto 0);
    signal rcstr: STD_LOGIC_VECTOR (7 downto 0);
    signal id: STD_LOGIC_VECTOR (7 downto 0);
    signal encoexit : STD_LOGIC_VECTOR (3 downto 0);
    
    signal col1: STD_LOGIC_VECTOR (15 downto 0);
    signal col2: STD_LOGIC_VECTOR (15 downto 0);
    signal col0: STD_LOGIC_VECTOR (15 downto 0);
    signal prodotto: STD_LOGIC_VECTOR (15 downto 0);
    signal o_reg2 : STD_LOGIC_VECTOR (15 downto 0);
    signal indi: STD_LOGIC_VECTOR (15 downto 0);
    signal indo: STD_LOGIC_VECTOR (15 downto 0);
    signal r1in: STD_LOGIC_VECTOR (15 downto 0);
    signal r1i: STD_LOGIC_VECTOR (15 downto 0);
    signal r1o: STD_LOGIC_VECTOR (15 downto 0);
    signal r1minus: STD_LOGIC_VECTOR (15 downto 0);
    signal r2i: STD_LOGIC_VECTOR (15 downto 0);
    signal r2o: STD_LOGIC_VECTOR (15 downto 0);
    signal r3o: STD_LOGIC_VECTOR (15 downto 0);
    signal ad2i: STD_LOGIC_VECTOR (15 downto 0);
    signal ad2o: STD_LOGIC_VECTOR (15 downto 0);
    signal advwo: STD_LOGIC_VECTOR (15 downto 0);
    signal advwi: STD_LOGIC_VECTOR (15 downto 0);

Begin

    addai<= i_data when sel_adda='0' else "XXXXXXXX"; 
    r_datai <=i_data when sel_adda='1' else "XXXXXXXX";
    
    rigai<= addai when sel_ps='1' else "XXXXXXXX";
    coloi<=addai when sel_ps='0' else "XXXXXXXX";
    
    
    sig_zero2<= '1' when (rigai = "00000000") else '0';
    sig_zero1<= '1' when (coloi = "00000000") else '0';

    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  ) then
            coloexit <= "00000000";
        elsif rising_edge(i_clk) then
            if(load_col = '1') then
                coloexit<=coloi;
            end if;
        end if;
    end process;

    col1<= ("00000000" & coloexit)+ colrs;
    
    with sel_col select
        col2<=  "0000000000000000" when '0' ,
                col1 when '1',
                "XXXXXXXXXXXXXXXX" when others;

    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  )then
            col0 <= "0000000000000000";
        elsif rising_edge(i_clk)  then
            if(load_cc= '1') then
                col0 <=col2;
            end if;
        end if;
    end process;

    Prodotto<= col0 when sel_f='1' else "XXXXXXXXXXXXXXXX";
    colrs<=col0 when sel_f='0' else "XXXXXXXXXXXXXXXX";
    
    
    
    
    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  ) then
            rigao <= "00000000";
        elsif rising_edge(i_clk)  then
            if(load_rig= '1') then
                rigao <=rigai;
            end if;
        end if;
    end process;


    with sel_rig select
        rci<=   rigao when '0' ,
                rcstr when '1',
                "XXXXXXXX" when others;


    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  )then
            rco <= "00000000";
        elsif rising_edge(i_clk)  then
            if(load_rc= '1') then
                rco<=rci;
            end if;
        end if;
    end process;


    sig_stopsum<= '1' when (rco= "00000000") else '0';
    
    
    rcstr<= rco - "00000001";
    
    
    r1in<= "0000000000000010" + prodotto;
    
    r1minus<= r1o-"0000000000000001";


    with sel_mm select
    r1i<=   r1minus when '0' ,
            r1in when '1',
            "XXXXXXXXXXXXXXXX" when others;


    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0' ) then
            r1o<= "0000000000000000";
        elsif rising_edge(i_clk)  then
            if(load_r1= '1') then
            r1o<=r1i;
            end if;
        end if;
    end process;


    sig_stopmm2<= '1' when (r1o= "0000000000000011") else '0';
    
    
    r2i<= "0000000000000011" + prodotto;
    
    
    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0')then
            r2o<= "0000000000000000";
        elsif rising_edge(i_clk)  then
            if(load_r2= '1') then
                r2o<=r2i;
            end if;
        end if;
    end process;


    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0' )then
            r3o<= "0000000000000000";
        elsif rising_edge(i_clk)  then
            if(load_r3= '1') then
                r3o<=prodotto;
            end if;
        end if;
    end process;


    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  )then
            ad2o<= "0000000000000010";
        elsif rising_edge(i_clk)  then
            if(load_ad2= '1') then
                ad2o<=ad2i;
            end if;
        end if;
    end process;

    
    ad2i<= "0000000000000001" + ad2o;
    
    
    sig_stoplett<= '1' when (ad2i=r2o) else '0';
    
    
    advwi <= r3o + ad2o;
    
    with sel_vw select
    advwo<= ad2o when '1' ,
            advwi when '0',
            "XXXXXXXXXXXXXXXX" when others;


    with sel_rv select
    indi<=  advwo when '1' ,
            r1o when '0',
            "XXXXXXXXXXXXXXXX" when others;
    
    
    process(i_clk, i_rst , i_start)
    begin
        if(i_rst='1' or i_start='0' ) then
            indo<= "0000000000000000";
        elsif rising_edge(i_clk)  then
            if(load_ad= '1') then
                indo<=indi;
            end if;
        end if;
    end process;


    with sel12 select
    o_address<= "0000000000000000" when "00",
                "0000000000000001" when "01" ,
                indo when "11",
                indo when "10",
                "XXXXXXXXXXXXXXXX"  when others;

    
    process(i_clk, i_rst, i_start)
    begin
        if (i_rst='1' or i_start='0' ) then
            r_datao<= "00000000";
        elsif rising_edge(i_clk)  then
            if(load_data= '1') then
                r_datao<=r_datai;
            end if;
        end if;
    end process;
    
    compa<= i_data when sel_ac='0' else "XXXXXXXX"; 
    Amp<=i_data when sel_ac='1' else "XXXXXXXX";
    
    
    mini<= compa when (compa<min) else min;
    maxi<= compa when (compa>max) else max;
    
    
    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0' )then
            min<= "11111111";
        elsif rising_edge(i_clk)  then
            if(load_min= '1') then
                min<=mini;
            end if;
        end if;
    end process;

    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  )then
            max<= "00000000";
        elsif rising_edge(i_clk)  then
            if(load_max= '1') then
                max<=maxi;
            end if;
        end if;
    end process;


    deltai<=max-min;
    
    
    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  )then
            deltao<= "00000000";
        elsif rising_edge(i_clk)  then
            if(load_delta= '1') then
                deltao<=deltai;
            end if;
        end if;
    end process;
    
    encoi<= deltao+"00000001";


    encoexit<= 
            "0111" when encoi>"01111111" and encoi<="11111111" else 
            "0110" when encoi>"00111111" and encoi<="01111111" else 
            "0101" when encoi>"00011111" and encoi<="00111111" else 
            "0100" when encoi>"00001111" and encoi<="00011111" else 
            "0011" when encoi>"00000111" and encoi<="00001111" else 
            "0010" when encoi>"00000011" and encoi<="00000111" else 
            "0001" when encoi>"00000001" and encoi<="00000011" else
            "0000" when encoi="00000001" else 
            "1000";
    

    Shifti<="1000"-encoexit;
    
    
    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  ) then
            shifto<= "0000";
        elsif rising_edge(i_clk)  then
            if(load_shift= '1') then
                shifto<=shifti;
            end if;
        end if;
    end process;
    
    
    minus<=amp-min;


    with shifto select
    risi<=  "00000000" & minus      when "0000",
            "0000000" & minus & "0" when "0001",
            "000000" & minus & "00" when "0010",
            "00000" & minus & "000" when "0011",
            "0000" & minus & "0000" when "0100",
            "000" & minus & "00000" when "0101",
            "00" & minus & "000000" when "0110",
            "0" & minus & "0000000" when "0111",
            minus & "00000000"      when others;


    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  ) then
            riso<= "0000000000000000";
        elsif rising_edge(i_clk)  then
            if(load_fin= '1') then
                riso<=risi;
            end if;
        end if;
    end process;
    
    id<= "11111111" when (riso>"0000000011111111") else riso(7 downto 0);



    process(i_clk, i_rst, i_start)
    begin
        if(i_rst='1' or i_start='0'  )then
            o_data<= "00000000";
        elsif rising_edge(i_clk)  then
            if(load_id= '1') then
                o_data<=id;
            end if;
        end if;
    end process;
    
    
end Behavioral;