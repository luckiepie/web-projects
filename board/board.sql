create table board(
	"size" varchar2(10)	-- ORA-00904: : invalid identifier
);

drop table board;

create table board(
	bno number(8),                   -- 글번호 
	name nvarchar2(10) not null,     -- 작성자
	password varchar2(15) not null,  -- 비밀번호
	title nvarchar2(50) not null,    -- 제목
	content nvarchar2(1000) not null, -- 내용
	attach nvarchar2(100),           -- 파일첨부
	re_ref number(8) not null,       -- 답변글 작성시 참조되는 글 번호
	re_lev number(8) not null,       -- 답변글 레벨
	re_seq number(8) not null,       -- 답변글 순서
	readcount number(8) default 0,   -- 조회수
	regdate date default sysdate     -- 작성날짜
);

alter table board add constraint pk_board primary key(bno);

create sequence board_seq;

insert into board(bno, name, password, title, content, attach, re_ref, re_lev, re_seq)
values (board_seq.nextval, '신짱구', '1234', 'jsp/servlet 게시판', '게시판을 작성해 봅시다', null, board_seq.currval, 0, 0);

insert into board(bno,name,password,title,content,attach,re_ref,re_lev,re_seq)
values(board_seq.nextval,'홍길동','1234','jsp/servlet 게시판','게시판 작성해 봅시다',null,board_seq.currval,0,0);

select * from board;

-- 조회수 업데이트
update board 
set readcount = readcount + 1 
where bno = 1;

-- 수정 조건 : bno, password 가 일치 시
-- 수정 : 제목, 내용, 파일첨부
-- 수정 : 제목, 내용

update BOARD
set title='새로운 타이틀', content='새로운 내용', attach='abcdef_1.jsp'
where bno=3 and password='12345';

update BOARD
set title='새로운 타이틀', content='새로운 내용'
where bno=3 and password='12345';

-- 댓글, 검색, 페이지 나누기

-- 게시물 전체 개수
select count(*) from board;

-- 가장 마지막 글 번호 확인
select max(bno) from board;

-- 더미 데이터
insert into board(bno, name, password, title, content, re_ref, re_lev, re_seq)
(select board_seq.nextval, name, password, title, content, board_seq.currval, re_lev, re_seq from board);

select bno, title, re_ref, re_seq, re_lev from board where bno=3082;


-- 첫번째 댓글
insert into board(bno, name, password, title, content, attach, re_ref, re_lev, re_seq)
values (board_seq.nextval, '댓글러', '1234', 're : 댓글1', '댓글 작성', null, 3082, 1, 1);

-- 원본 글과 댓글 그룹으로 가져오기
select bno, title, re_ref, re_seq, re_lev from board where re_ref=3082;

-- 두번째 댓글
insert into board(bno, name, password, title, content, attach, re_ref, re_lev, re_seq)
values (board_seq.nextval, '댓글러2', '1234', 're : 댓글2', '댓글 작성2', null, 3082, 1, 1);

-- 댓글 작성시 댓글을 최신 순으로 추출할 수 있어야 함(re_seq 사용)

-- 1) 기존 댓글의 re_seq 값을 업데이트
-- 	  update board set re_seq = re_seq + 1 where re_ref = 원본글의 re_ref and re_seq > 원본글의 re_seq

-- 2) 새로운 댓글 삽입
-- 댓글 작성(re_ref: 원본글의 re_ref 값과 동일하게 삽입,
--			 re_lev : 원본글의 re_lev +1 삽입
--			 re_seq : 원본글의 re_seq +1 삽입












