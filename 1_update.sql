update tableb b2
set b2.balance = ( with b3 as ( select b1.accno,b1.txndt,b1.balance,
nvl(b1.balance,
lead(b1.balance,1,0) over(partition by b1.accno order by b1.txndt desc)  ) as prev_bal
from tableb b1)
select b3.prev_bal
from b3
where b2.accno = b3.accno
and b3.balance is null)
where b2.balance is null;