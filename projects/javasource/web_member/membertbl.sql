create table membertbl(
	userid varchar2(15) primary key,
	password varchar2(20) not null,
	name nvarchar2(10) not null,
	gender nvarchar2(2) not null,
	email varchar2(50) not null
);

insert into membertbl values('zzangzzang9', 'zzang9','신짱구', '남', 'zzangzzang9@gmail.com' );
insert into membertbl values('kim123', 'kim123@','김철수', '남', 'ironwater1212@gmail.com' );
