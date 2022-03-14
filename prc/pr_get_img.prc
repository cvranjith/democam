create or replace procedure pr_get_img(p_id in varchar2)
is
l varchar2(4000);
c clob;
a integer := 4000;
n integer := 1;
begin
    for i in (select * from tb_img where sess = p_id)
    loop
        c := i.img_data;
        htp.prn('<img src="');
        for j in 1..200
        loop
            begin
                dbms_lob.read(c,a,n,l);
                n := n + a;
                htp.prn(l);
            exception
                when no_data_found
                then
                    exit;
            end;
        end loop;
        htp.prn('" />');
    end loop;
end;
