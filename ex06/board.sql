-- 게시글을 위한 테이블
create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);
create sequence seq_board;
alter table tbl_board add constraint pk_board primary key (bno);

--게시글 더미데이터
insert into tbl_board (bno, title, content, writer)
values (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');

insert into tbl_board (bno, title, content, writer)
(select seq_board.nextval, title, content, writer from TBL_BOARD);

select count(*) from tbl_board;

-- 댓글을 위한 테이블
create table tbl_reply (
    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);

--rno를 위한 시퀀스 생성
create sequence seq_reply;
--rno pk설정
alter table tbl_reply add constraint pk_reply primary key (rno);
--외래키 설정하여 tbl_board 참조설정
alter table tbl_reply add constraint fk_reply_board
foreign key (bno) references tbl_board (bno);

select * from tbl_board where rownum < 15 order by bno desc;

select * from tbl_reply order by rno desc;

insert into tbl_reply (rno, bno, reply, replyer)
values (seq_reply.nextval, 505, '댓글 테스트', 'replyer');

select * from tbl_reply where bno=766;
--댓글 인덱스 생성
create index idx_reply on tbl_reply(bno desc, rno asc);

--특정 게시물의 rno순번대로 조회할 경우
select /*+INDEX(tbl_reply idx_reply)*/
rownum rn, bno, rno, reply, replyer, replyDate, updatedate
from tbl_reply
where bno = 772 and rno >0;

--댓글을 10개씩 2페이지를 가져온다면
select rno, bno, reply, replyer, replydate, updatedate
from
(
select /*+INDEX(tbl_reply idx_reply)*/
rownum rn, bno, rno, reply, replyer, replyDate, updatedate
from tbl_reply
where bno = 772
    and rno > 0
    and rownum <=20
) where rn >10;

select * from tbl_reply where bno = 772;

select count(rno) from tbl_reply where bno=772;

-- aop 예제 테이블 생성

create table tbl_sample1(col1 varchar2(500));

create table tbl_sample2(col2 varchar2(50));

select * from tbl_sample1;
select * from tbl_sample2;

delete tbl_sample1;
delete tbl_sample2;
commit;
-- 기존 테이블에 칼럼 추가
alter table tbl_board add (replycnt number default 0);

--기존에 댓글이 존재했다면 replycnt에 반영해줘야한다.
update tbl_board set replycnt = (select count(rno) 
from tbl_reply where tbl_reply.bno = tbl_board.bno);

select bno, title, content, writer, regdate, updatedate, replycnt
from (select /*+INDEX_DESC(tbl_board pk_board)*/
rownum rn, bno, title, content, writer, regdate, updatedate, replycnt
from tbl_board where rownum <= 1*15)
where rn > (1-1)*15;

--첨부파일 테이블
create table tbl_attach(
    uuid varchar2(100) not null,
    uploadPath varchar2(200) not null,
    fileName varchar2(100) not null,
    filetype char(1) not null,
    bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid);
alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);
