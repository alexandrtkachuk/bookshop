#!/usr/bin/perl 

#test Models::Performers::Authors
use warnings;
use strict;
use File::Basename;
use constant TDIR=>dirname(__FILE__);
use lib TDIR.'/../Libs';
use lib TDIR.'/../';
use lib  '../Libs';
use lib  '../';


use base qw(Test::Class);
use Test::MockObject;
use Test::More 'no_plan';
use Models::Performers::Authors;

my ($mockObj ,$authors);

sub startup : Test(startup=>2)
{
    $mockObj = Test::MockObject->new();
    $mockObj->fake_new( 'Models::Interfaces::Sql');
    $mockObj->mock( 'connect', sub {1} );
    $authors = Models::Performers::Authors->new();
    ok($authors,'create clas authors');
    isa_ok($authors, 'Models::Performers::Authors');
}

sub authors_1_select :Test(4)
{
    can_ok($authors,'add');
    is($authors->add(),0,'return 0, not params');
    $mockObj->mock( 'select', sub {1} );
    $mockObj->mock( 'setTable', sub {1} );
    $mockObj->mock( 'where', sub {1} );
    $mockObj->mock( 'execute', sub {1} );
    $mockObj->mock( 'getRows', sub {1} ); 
    is($authors->add('name'),0,'return 0 , param name (getRows return 1)');    
    $mockObj->mock( 'insert', sub {1} );
    $mockObj->mock( 'getRows', sub {0} );
    is($authors->add('name'),1,'return 1 , 
        param name (getRows return 0), not this name is DB');
}

sub authors_getAll :Test(3)
{
    can_ok($authors,'getAll');
    $mockObj->mock( 'execute', sub {0} );
    $mockObj->mock( 'getError', sub {1} );
    is($authors->getAll(),0,'return 0 ,(execucet return 0, and crate error)');
    $mockObj->mock( 'execute', sub {1} );
    $mockObj->mock( 'getResult', sub {2} );
    is($authors->getAll(),2,'good result');
}


Test::Class->runtests;
