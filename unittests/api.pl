#!/usr/bin/perl 

#test Controllers::CtrlPages::Api
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
use Controllers::CtrlPages::Api;

my ($api);

sub startup : Test(startup=>2)
{
    $api = Controllers::CtrlPages::Api->new();
    ok($api,'create clas api');
   isa_ok($api, 'Controllers::CtrlPages::Api'); 
}

sub api_go :Test(1)
{
    can_ok($api,'go');
}


sub api_setSale :Test(12)
{
    can_ok($api,'setSale');
    my $userMock =  Test::MockObject->new();
    $userMock->fake_new( 'Models::Performers::User');
    $userMock->mock( 'setSale', sub {1} );
    my $varibleMock =  Test::MockObject->new();
    $varibleMock->fake_new( 'Models::Validators::Varibles');
    $varibleMock->mock( 'isNumeric', sub {1} );

    is($api->setSale(),0,'not params');
    is($api->setSale(1,4),1,'good result');    
    is($api->setSale(1,-4),0,'wrong params');
    is($api->setSale(1,101),0,'wrong params');
    is($api->setSale(1,100),0,'wrong params');
    is($api->setSale(1,99),1,'good result');
    is($api->setSale(1,0),0,'wrong params');
    is($api->setSale(0,10),0,'wrong params');
    is($api->setSale(-9,0),0,'wrong params');
    $varibleMock->mock( 'isNumeric', sub {0} );
    is($api->setSale('rewrwe',10),0,'wrong params');
    is($api->setSale(-9,'rewrwerwe'),0,'wrong params');
}

sub api_setStatus :Test
{
    can_ok($api,'setStatus');
}
Test::Class->runtests;
