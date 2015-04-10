#!/usr/bin/perl 

use warnings;
use strict;

use lib '../';
use lib '../Models/Utilits';

use Config::Config;
use Models::Interfaces::Sql;
use Test::MockObject;

use Test::More 'no_plan';

my $sql = Models::Interfaces::Sql->new();
is($sql,0,'no create class, not params');

$sql = Models::Interfaces::Sql->new('bdname','host','user','pass');

ok($sql,'Create class SQL');
isa_ok($sql, 'Models::Interfaces::Sql');


can_ok($sql,'select');
can_ok($sql,'connect');
can_ok($sql,'getSql');
can_ok($sql,'getRows');
can_ok($sql,'getError');
can_ok($sql, $_) for qw( OrederBy where);

is( $sql->connect(), 0, 'resul = 0 , param is wrong' );

isnt($sql->select(),1,'no connect to bd ' );
is($sql->where(),0,'no connect to bd ' );


$sql =  Models::Interfaces::Sql->new(
        Config::Config::DBUSER,
        Config::Config::DBHOST,
        Config::Config::DBNAME,
        Config::Config::DBPASS, 1);

is( $sql->connect(), 1, 'good connect for new copy Class' );
is( $sql->select( ),0, 'return 0, no param' );
is($sql->select(['title','id','price'] ),1,' cearte select  ' );
is($sql->setTable(),0, 'no param');
is($sql->setTable('shop_books'),1, 'set table');
is($sql->where('id',3),1,"set WHERE id = '3'");
is($sql->execute(),1, 'query is create and is prepare  good');
like($sql->getSql(), 
    qr/^(SELECT *title, id, price *FROM shop_books *WHERE *id = '3') *$/, 
    'true my query');
