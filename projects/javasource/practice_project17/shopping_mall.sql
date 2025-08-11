CREATE TABLE  Product  (
	 p_code 	Number(10)	NOT NULL,
	 p_name 	VARCHAR2(100)	NOT NULL,
	 p_price 	NUMBER(10)	NOT NULL,
	 p_disprice NUMBER(10)	,
	 p_type 	VARCHAR2(50)	NOT NULL,
	 p_content 	VARCHAR2(2000)	NOT NULL,
	 p_sale 	NUMBER(10),
	 t_amount 	NUMBER(10)	
);

-- 총 수량과 판매량은 0으로 기본 설정

CREATE TABLE  Product  (
    p_code    Number(10)   NOT NULL,
    p_name    VARCHAR2(100)   NOT NULL,
    p_price    NUMBER(10)   NOT NULL,
    p_disprice NUMBER(10),
    p_type    VARCHAR2(50)   NOT NULL,
    p_content    VARCHAR2(2000)   NOT NULL,
    p_sale    NUMBER(10) default 0,
    t_amount    NUMBER(10) default 0
);

select * from product;
select * from productOpt;

select * from productAttach;

update productopt set p_amount=0 where p_code=153 and po_color='BRWON';
drop table product;
drop table OrderInfo;
drop table Basket;
drop table ProductOpt;
drop table ProductBoard;
drop table Cart;
drop table productAttach;



CREATE TABLE  QnA  (
	 qno 	NUMBER(10)	NOT NULL primary key,
	 bno 	NUMBER(10)	NOT NULL,
     user_id 	VARCHAR2(100)	NOT NULL,
	 q_title 	VARCHAR2(100) NOT NULL,
	 q_content 	VARCHAR2(1000) NOT NULL,
     q_answer VARCHAR2(1000),
     quser_id 	VARCHAR2(100),
     reg_date 	 date default sysdate,
     update_date date default sysdate,
     qna_level char(1) default '0',
     qna_secret char(1) default '0',
     constraint fk_board_qna foreign key(bno) 
     references ProductBoard(bno) on delete cascade,
     constraint fk_member_qna foreign key(user_id) 
     references member(user_id) on delete cascade
);


drop table qna;
select * from qna;

select count(user_id) from member;

select * from member;

-- Product 테이블에 reg_date 컬럼 추가
ALTER TABLE Product ADD reg_date 	date default sysdate;

-- member 테이블에 reg_date 컬럼 추가
ALTER TABLE member ADD reg_date 	date default sysdate;

select * from product;

select * from member;

select * from auth;

insert into member
	(user_id, password, name, person_num1, person_num2, email, phone_num, address)
values('user01', 'pw01', '홍길동', '000101', '38562950', 'email@gmail.com', '01000000000', '서울');

select user_id, name from member;

CREATE TABLE  Member  (
	 user_id 	VARCHAR2(50)	NOT NULL,
	 password 	VARCHAR2(100)	NOT NULL,
	 name 	VARCHAR2(20)	NOT NULL,
	 person_num1 	VARCHAR2(10)	NOT NULL,
	 person_num2 	VARCHAR2(100)	NOT NULL,
	 email 	VARCHAR2(50)	NULL,
	 phone_num 	VARCHAR2(15)	NOT NULL,
	 address 	VARCHAR2(1000)	NULL
);

drop table member;

select * from member;

CREATE TABLE  OrderInfo  (
     order_num     NUMBER(10)    NOT NULL,
     user_id     VARCHAR2(50)    NOT NULL,
     p_code     Number(10)    NOT NULL,
     p_name     VARCHAR2(100)    NOT NULL,
     po_size     VARCHAR2(50)    NOT NULL,
     po_color     VARCHAR2(50)    NOT NULL,
     p_amount     NUMBER(10)    NOT NULL,
     p_price     NUMBER(10)    NOT NULL,
     oreg_date  date default sysdate,
     constraint fk_orderinfo_member foreign key(user_id) 
     references member(user_id) on delete cascade
);

drop table p_code;

drop table orderinfo;

select * from orderinfo;

-- 장바구니
CREATE TABLE  Basket  (
	 basket 	NUMBER(15)	NOT NULL,
	 p_code 	Number(10)	NOT NULL,
	 order_num 	NUMBER(15)	NOT NULL,
	 b_size 	VARCHAR2(50)	NOT NULL,
	 b_color 	VARCHAR2(50)	NOT NULL,
	 b_amount 	NUMBER(10)	NOT NULL,
	 total_price 	NUMBER(10)	NOT NULL
);

select * from basket;

-- 권한
CREATE TABLE  Auth  (
	 user_id 	VARCHAR2(50)	NOT NULL,
	 auth 	VARCHAR2(20)	NOT NULL
);

drop table auth;

CREATE TABLE  ProductOpt  (
	 p_code 	Number(10)	NOT NULL,
	 po_size 	VARCHAR2(50)	NOT NULL,
	 po_color 	VARCHAR2(50)	NOT NULL,
	 p_amount 	NUMBER(10)	NOT NULL
);

select * from productopt;

CREATE TABLE  ProductBoard  (
	 bno 	NUMBER(10)	NOT NULL,
	 p_code 	Number(10)	NOT NULL,
	 pb_content 	VARCHAR2(2000)	NOT NULL,
	 reg_date 	date default sysdate
);

CREATE TABLE  Review  (
	 rno 	NUMBER(10)	NOT NULL,
	 bno 	NUMBER(10)	NOT NULL,
	 r_title 	VARCHAR2(50)	NOT NULL,
	 r_content 	VARCHAR2(2000)	NOT NULL,
	 replyer 	VARCHAR2(1000)	NOT NULL,
	 rv_image 	VARCHAR2(100)	NOT NULL,
	 reg_date 	date default sysdate
);

CREATE TABLE  ProductAttach  (
     p_code     Number(10)    NOT NULL,
     uuid   varchar2(100) NOT NULL,
     uploadpath varchar2(200) NOT NULL,
     filename     varchar2(200) NOT NULL
);

CREATE TABLE  QnA  (
	 qno 	NUMBER(10)	NOT NULL,
	 bno 	NUMBER(10)	NOT NULL,
	 q_title 	VARCHAR2(50)	NOT NULL,
	 q_content 	VARCHAR2(1000)	NOT NULL,
	 q_writer 	VARCHAR2(20)	NOT NULL,
	 req_date 	 date default sysdate,
	 qa_ref 	NUMBER(10)	NOT NULL,
	 qa_lev 	NUMBER(10)	NOT NULL
);

-- 리뷰 사진 모음
CREATE TABLE  CustomerAttach  (
     bno     NUMBER(10)    NOT NULL,
     uuid varchar2(100) NOT NULL,
     uploadpath varchar2(200) NOT NULL,
     filename     VARCHAR2(200) NOT NULL,
     constraint fk_customer_attach foreign key(bno) 
     references ProductBoard(bno) on delete cascade
);

ALTER TABLE  Product  ADD CONSTRAINT  PK_PRODUCT  PRIMARY KEY (
     p_code 
);

ALTER TABLE  ProductAttach  ADD CONSTRAINT  FK_P_Board_P_Attach_1  FOREIGN KEY (
     p_code
)
REFERENCES  Product  (
     p_code
);


----------------------------------------------------------------

select * from PRODUCT;

select * from PRODUCTATTACH;

delete from PRODUCTATTACH;

-- 인기순
select uuid, uploadpath, filename, p_a.p_code, p_price, p_name
from productattach p_a left outer join product p on p_a.p_code = p.p_code
order by p_sale;

-- 옵션 테이블 판매량 컬럼 추가
alter table productopt add p_sale number(10);

CREATE TABLE  ProductAttach  (
     p_code     Number(10)    NOT NULL,
     uuid   varchar2(100) NOT NULL,
     uploadpath varchar2(200) NOT NULL,
     filename     varchar2(200) NOT NULL
);
select * from PRODUCTATTACH;

drop table ProductAttach;

-- 최신순
select uuid, uploadpath, filename, p_a.p_code, p_price, p_name, p.reg_date, p.p_content
from productattach p_a left outer join product p on p_a.p_code = p.p_code
order by reg_date desc;

select * from PRODUCT;

select * from PRODUCTATTACH;

-- 로그인 기억하기 테이블(아래 그대로 만들어 줘야 알아서 인식.)
create table persistent_logins(
	username varchar(64) not null,
	series varchar(64) primary key,
	token varchar(64) not null,
	last_used timestamp not null
);

-- member 테이블 기본키 설정
alter table member add constraint member_pk primary key(user_id);

-- 로그인 권한 외래키 설정 및 cascade 설정
alter table auth add constraint auth_fk foreign key(user_id) references member(user_id)
on delete cascade;

-- 장바구니 테이블 임시 설정
CREATE TABLE  Cart  (
     user_id     VARCHAR2(50)    NOT NULL,
     p_code     Number(10)    NOT NULL,
     p_name     VARCHAR2(100)    NOT NULL,
     po_size     VARCHAR2(50)    NOT NULL,
     po_color     VARCHAR2(50)    NOT NULL,
     p_amount     NUMBER(10)    NOT NULL,
     p_price     NUMBER(10)    NOT NULL
);

drop table cart;

alter table cart add valid_price number(10);

select * from PRODUCTopt;
select * from PRODUCT;

insert into Cart(user_id, p_code, p_name, po_size, po_color,p_amount,p_price, valid_price)
values('aadd19','p_code1','p_name1','250mm','Red', 1, 10000, 10000);

insert into Cart(user_id, p_code, p_name, po_size, po_color,p_amount,p_price, valid_price)
values('aadd19','p_code13','p_name13','Small','Orange', 2, 5000, 10000);

insert into Cart(user_id, p_code, p_name, po_size, po_color,p_amount,p_price, valid_price)
values('aadd19',2 ,'상의2','M','Red', 2, 15000, 30000);

select * from member;

select * from cart where user_id = 'aadd19';

update cart set valid_price = 70000 where po_size = 'Small';

alter table Cart add constraint fk_cart_member foreign key(user_id) references member(user_id) on delete cascade;

select * from PRODUCTopt;
select * from PRODUCT;

select cart.user_id, cart.p_code, p_name, p_price, po_size, po_color, p_amount, uuid, uploadpath, filename 
from Cart cart left outer join ProductAttach attach on cart.p_code = attach.p_code
where user_id = 'aadd19';

delete from cart;

select * from product;


update PRODUCTopt set p_amount = 3 where p_code='p_code0';

update ProductAttach set filename = 'pic01.jpg' where p_code = 'p_code0';

select * from PRODUCT;
select * from PRODUCTOPT;

update PRODUCT set p_sale = 0;

select uuid, uploadpath, filename, p_a.p_code, p_price, p_name, p_type,p_sale
from productattach p_a left outer join product p on p_a.p_code = p.p_code
where t_amount > 0
order by p.p_sale desc;

CREATE TABLE  OrderInfo  (
     order_num     NUMBER(10)    NOT NULL,
     user_id     VARCHAR2(50)    NOT NULL,
     p_code Number(10)    NOT NULL,
     p_name     VARCHAR2(100)    NOT NULL,
     po_size     VARCHAR2(50)    NOT NULL,
     po_color     VARCHAR2(50)    NOT NULL,
     p_amount     NUMBER(10)    NOT NULL,
     p_price     NUMBER(10)    NOT NULL,
     oreg_date  date default sysdate,
     constraint fk_orderinfo_member foreign key(user_id) 
     references member(user_id) on delete cascade
);

drop table orderinfo;

drop table orderinfo;

delete from ORDERINFO;

select * from ORDERINFO;

-- p_code 시퀀스
create SEQUENCE product_seq
    increment by 1
    start with 1
    maxvalue 99999999
    minvalue 1
    nocycle;
    
-- bno 시퀀스
create SEQUENCE bno_seq
    increment by 1
    start with 1
    maxvalue 99999999
    minvalue 1
    nocycle;
    

insert into ORDERINFO(order_num, user_id, p_code, p_name, po_size, po_color, p_amount, p_price) 
values(1000, 'aadd19', 3, 'p_name1', '250mm', 'red', 2, 30000);

delete from ORDERINFO;

select uuid, uploadpath, filename, orderinfo.p_code, p_price, p_name, user_id, po_color,po_size, order_num,p_amount,oreg_date
from OrderInfo orderinfo left outer join ProductAttach p on orderinfo.p_code = p.p_code where user_id = 'aadd19';


select uuid, uploadpath, filename, p_a.p_code, p_price, p_name, p_type
from productattach p_a left outer join product p on p_a.p_code = p.p_code
where t_amount > 0
order by p.p_sale desc;

select * from product;
delete from product where p_Code = 3;
update product set t_amount = 1;

select uuid, uploadpath, filename, p_a.p_code, p_price, p_name, p.reg_date, p.p_content
		from productattach p_a left outer join product p on p_a.p_code = p.p_code
		order by reg_date desc;
		
		
select uuid, uploadpath, filename, p_a.p_code, p_price, p_name, p_type, p.p_content
from productattach p_a left outer join product p on p_a.p_code = p.p_code
where t_amount > 0
order by p.p_sale desc;

---------------------------------------------------------------------------------------------
-- 이메일 관련
-- member 테이블에서 주민번호 삭제

select * from member;
select * from qna;
select * from ORDERINFO;
select * from cart;

drop table qna;
drop table orderinfo;
drop table cart;
drop table member;


-- member 테이블 새로 생성(주민번호 제거, email not null조건 추가)
CREATE TABLE  Member  (
	 user_id 	VARCHAR2(50)	NOT NULL primary key,
	 password 	VARCHAR2(100)	NOT NULL,
	 name 	VARCHAR2(20)	NOT NULL,
	 email 	VARCHAR2(50)	NOT NULL,
	 phone_num 	VARCHAR2(15)	NOT NULL,
	 address 	VARCHAR2(1000)	NULL,
	 reg_date 	date default sysdate
);

-- member 테이블 기본키 설정
alter table member add constraint member_pk primary key(user_id);


-- OrderInfo 테이블 다시 생성
CREATE TABLE  OrderInfo  (
     order_num     NUMBER(10)    NOT NULL,
     user_id     VARCHAR2(50)    NOT NULL,
     p_code     Number(10)    NOT NULL,
     p_name     VARCHAR2(100)    NOT NULL,
     po_size     VARCHAR2(50)    NOT NULL,
     po_color     VARCHAR2(50)    NOT NULL,
     p_amount     NUMBER(10)    NOT NULL,
     p_price     NUMBER(10)    NOT NULL,
     oreg_date  date default sysdate,
     constraint fk_orderinfo_member foreign key(user_id) 
     references member(user_id) on delete cascade
);

-- 장바구니 테이블 다시 생성
CREATE TABLE  Cart  (
     user_id     VARCHAR2(50)    NOT NULL,
     p_code     Number(10)    NOT NULL,
     p_name     VARCHAR2(100)    NOT NULL,
     po_size     VARCHAR2(50)    NOT NULL,
     po_color     VARCHAR2(50)    NOT NULL,
     p_amount     NUMBER(10)    NOT NULL,
     p_price     NUMBER(10)    NOT NULL
);



-- qna 테이블 다시 생성
CREATE TABLE  QnA  (
	 qno 	NUMBER(10)	NOT NULL primary key,
	 bno 	NUMBER(10)	NOT NULL,
     user_id 	VARCHAR2(100)	NOT NULL,
	 q_title 	VARCHAR2(100) NOT NULL,
	 q_content 	VARCHAR2(1000) NOT NULL,
     q_answer VARCHAR2(1000),
     quser_id 	VARCHAR2(100),
     reg_date 	 date default sysdate,
     update_date date default sysdate,
     qna_level char(1) default '0',
     qna_secret char(1) default '0'
);

alter table ProductBoard add constraint ProductBoard_pk primary key(bno);
alter table qna add constraint fk_board_qna foreign key(bno)  references ProductBoard(bno) on delete cascade;

alter table qna add constraint fk_member_qna foreign key(user_id) references member(user_id) on delete cascade;

select * from all_constraints;

select * from ProductBoard;

---------------------------------

-- 권한 관련

drop table auth;

CREATE TABLE  Auth  (
	 user_id 	VARCHAR2(50)	NOT NULL,
	 auth 	VARCHAR2(20)	NOT NULL
);

-- 로그인 권한 외래키 설정 및 cascade 설정
alter table auth add constraint auth_fk foreign key(user_id) references member(user_id)
on delete cascade;
---------------------------------------------------------------------------------------------
