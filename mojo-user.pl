use strict;
use warnings;


use Mojolicious::Lite -signatures;
use Mojolicious::Lite;
use JSON;

use DBI;

my $database = "PassSys";
my $hostname = "localhost";
my $username = "PassSys";
my $password = "PassSys";

my $dsn = "DBI:mysql:database=$database;host=$hostname";

my $dbh = DBI->connect( $dsn, $username, $password );

use lib './';
use ModelUser;



get '/' => sub ($c) {

if ($c->session->{username} eq "") {
        $c->redirect_to('/SignIn&SignUp.html');
    }
    else {
        #$c->render( text => "Current user : " . $c->session->{username} );
    }
};


get '/createUser' => sub ($c) {
    my $username    = $c->param('username');
    my $email  = $c->param('email');
    my $password      = $c->param('password');

    my $s = new ModelUser();
    $s->setUser($username, $email, $password);
    $s->createUser($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    $c->render(text => "Create row for $username - $email - $password");
};


get '/read' => sub ($c) {
      my $username = $c->param("username");
      my $password = $c->param("password");

    my $s = new ModelUser;


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    
    $c->render( text => $s->read( $dbh, $username, $password ) );
};


get '/checkUser' => sub ($c) {
    my $username = $c->param('username');
    my $entered_email = $c->param('email');

    my $s = new ModelUser;
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    
    $c->render( text => $s->readCheckUserz( $dbh, $entered_email,$username ) );
};



get '/resetPassword' => sub ($c) {
    my $reset_email = $c->param('email');

    my $s = new ModelUser;
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    
    $c->render( text => $s->readResetEmail( $dbh, $reset_email) );
};


get '/updatePassword' => sub ($c) {
    my $email       = $c->param('email');
    my $password     = $c->param('password');

    my $s = new ModelUser;

    $s->updateNewPassword($password);
    $s->updatePassword( $dbh, $email);

    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );
    $c->render( text => "Update row... siri=$email" );

};



get '/createServs' => sub ($c) {
    my $id_user  = $c->param("id_user");
    my $name  = $c->param("name");
    my $email = $c->param('email');
    my $phone = $c->param('phone');
    my $car = $c->param('car');
    my $plate = $c->param('plate');
    my $date = $c->param('date');

    my $s = new ModelUser;

   print "id_user: $id_user , Name: $name, Email: $email, Phone: $phone, Car: $car, Plate: $plate, Date: $date\n";


    $s->setServices($id_user, $name, $email, $phone, $car,$plate, $date);
    $s->createServss($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    # Response
    $c->render(text => "Create row for $id_user - $name - $email - $phone - $car - $plate - $date");
};



get '/createBooking' => sub ($c) {
    my $id_service  = $c->param("id_service");
    my $id_user  = $c->param("id_user");
    my $name  = $c->param("name");
    my $email = $c->param('email');
    my $phone = $c->param('phone');
    my $car = $c->param('car');
    my $plate = $c->param('plate');
    my $date = $c->param('date');

    my $s = new ModelUser;

   print " APAAAAid_user: $id_service id_user: $id_user , Name: $name, Email: $email, Phone: $phone, Car: $car, Plate: $plate, Date: $date\n";


    $s->setBook($id_service, $id_user, $name, $email, $phone, $car,$plate, $date);
    $s->createBook($dbh);


    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    # Response
    $c->render(text => "Create row for $id_service - $id_user - $name - $email - $phone - $car - $plate - $date");
};

get '/readServs' => sub ($c) {
    my $id_user = $c->param("id_user");

     print "id_users: $id_user.\n";

    my $s = new ModelUser;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );

    $c->render( text => $s->readServsx( $dbh, $id_user ) );
 
    
};


get '/readAllServsData' => sub ($c) {
    # my $id_user = $c->param("id_user");

    #  print "id_users: $id_user.\n";

    my $s = new ModelUser;

    ### Disable CORS policy by browser
    $c->res->headers->header( 'Access-Control-Allow-Origin' => '*' );


    $c->render( text => $s->readAllServs( $dbh,));
    
    
};


app->start;


