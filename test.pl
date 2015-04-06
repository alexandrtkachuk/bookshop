#!/usr/bin/perl 

use warnings;
use strict;

use File::Basename;

use constant TDIR=>dirname(__FILE__);
use lib TDIR;
use lib TDIR.'/Models/Utilits';
use Models::Performers::Book;
use Models::Utilits::Debug;
use Data::Dumper;
use Models::Performers::Admin;
my $debug = Models::Utilits::Debug->new();

sub addbook
{
    my $book =  Models::Performers::Book->new();



    my @arrauthor=(1,2,3);
    my @arrgenre=(1,2);
    
    print Dumper @arrauthor;
    my $res=$book->add('titel',120,'myimage.jpg','info',\@arrauthor, \@arrgenre);


    if($res)
    {
        print "good\n";
    }
    else
    {
        print "no\n";
        #my $debug = Models::Utilits::Debug->new();
        #my $d=$debug->getMsg();
        #print  Dumper(\$d);

    }
}


sub getAllBooks
{
    # my $book =  Models::Performers::Book->new();
    #my $res = $book->getAll();
    
}


sub addadmin
{
    my $admin= Models::Performers::Admin->new();
    if($admin->add( 'admin','admin','admin@mail.ru'))
    {
        print 'admin add';
    }
    
}


sub getAllbooks
{
    print "Get all books:\n";
    my $book =  Models::Performers::Book->new();
    my $res=$book->getAll();
    print  Dumper $res;
    #print $res;
    print "\n";
}

sub main
{

    addadmin();
    #addbook();
    getAllbooks();
    my $d=$debug->getMsg();
        print  Dumper(\$d);

}

#select DISTINCT shop_books.id, shop_books.title ,(
#   SELECT GROUP_CONCAT( a.name ) as idauthor 
#   FROM shop_book2author b2a , shop_author a 
#   WHERE b2a.idbook = shop_books.id AND a.id = b2a.idauthor) 
#FROM shop_books ;


main();

