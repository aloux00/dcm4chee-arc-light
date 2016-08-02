alter table patient add num_studies int4;
update patient set num_studies = (
  select count(*) from study where study.patient_fk=patient.pk and study.rejection_state in (0,1));
alter table location add multi_ref int4;
alter table location add uidmap_fk int8;
alter table location add object_type int4;
update location set object_type = 0;
alter table location alter object_type set not null;
alter table location alter tsuid drop not null;
create table uidmap (pk int8 not null, uidmap bytea not null, primary key (pk));
create index UK_i1lnahmehau3r3j9pdyxg3p3y on location (multi_ref);
alter table location add constraint FK_bfk5vl6eoxaf0hhwiu3rbgmkn foreign key (uidmap_fk) references uidmap;
create index FK_bfk5vl6eoxaf0hhwiu3rbgmkn on location (uidmap_fk) ;
create sequence uidmap_pk_seq;