use strict;
use warnings;
use JSON;
use Mojolicious::Lite;


package ModelUser;


sub new {
    my $class = shift @_;
    return bless {
        'id_service' => undef,
        'id_user' => undef,
        "username"  => "???",
        "email"     => "???",
        "password" => "???",
        "phone"  => "???",
        "car"     => "???",
        "plate" => "???",
        "date" => "???"
    }, $class;
}


sub setUser {
  my $this = shift @_;
  
  my $username = shift @_;
  my $email = shift @_;
  my $password = shift @_;
  
  $this->{'username'} = $username;
  $this->{'email'} = $email;
  $this->{'password'} = $password;
  
}


sub updateNewPassword {
  my $this = shift @_;
  
  my $Newpassword = shift @_;
  $this->{'password'} = $Newpassword;
  
}



sub createUser {

    my $this = shift @_;
    my $dbh = shift @_;
    my $sth = undef;
    
    if ($sth = $dbh->prepare('INSERT INTO user(username, email, password) values (?, ?, password(?))')) {
        if ($sth->execute($this->{'username'}, $this->{'email'},$this->{'password'})) {
            print "Success create new user...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}



sub read {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $username = shift @_;
    my $password = shift @_;
    # print "Values: username=$username, password=$password\n";
    my $sth = undef; 
        if ($sth = $dbh->prepare('SELECT * FROM user WHERE username=? AND  password=password(?)')) {

            if ($sth->execute($username, $password)) {
                        my $ref = $sth->fetchrow_hashref();        
                        if ($ref) {
                            return JSON->new->pretty->encode($ref);
                        } else {
                             return undef;
                                  
                        }

                    } else {
                        # SQL execution error
                        return JSON->new->pretty->encode({ error => $dbh->errstr() });
                    }
        }    
        else {
            print "Error: $dbh->errstr()\n";
        }  
}




sub readCheckUserz {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $email = shift @_;
    my $username = shift @_;
    # print "Values: username=$username, password=$password\n";
    my $sth = undef; 
        if ($sth = $dbh->prepare('SELECT COUNT(*) FROM user WHERE email = ? OR username = ?')) {

            if ($sth->execute($email, $username)) {
            my ($count) = $sth->fetchrow_array;
            $sth->finish();  
            return $count;     
                          
   
                    } else {
                        # SQL execution error
                        return JSON->new->pretty->encode({ error => $dbh->errstr() });
                    }
        }    
        else {
            print "Error: $dbh->errstr()\n";
        }  
}



sub readResetEmail {
    my $this = shift @_;
    my $dbh = shift @_;
    my $email = shift @_;
#    print "Values: Email APA?=$email";
    my $sth = undef; 
        if ($sth = $dbh->prepare('SELECT COUNT(*) FROM user WHERE email = ?')) {

            if ($sth->execute($email)) {
            my ($count) = $sth->fetchrow_array;
            $sth->finish();  
            return $count;     
                          
                    } else {
                        # SQL execution error
                        return JSON->new->pretty->encode({ error => $dbh->errstr() });
                    }
        }    
        else {
            print "Error: $dbh->errstr()\n";
        }  
}


sub updatePassword {
    my $this = shift @_;
    
    my $dbh = shift @_;
    my $email = shift @_;
    my $sth = undef;

    print "PASSWORDDDD= {'password'}\n";
    
    if ($sth = $dbh->prepare('UPDATE user SET password=password(?) WHERE email=?')) {
        if ($sth->execute($this->{'password'}, $email)) {
            print "Success update user password...\n";
        } else {
            print "Error: $dbh->errstr()\n";
        }
    } else {
        print "Error: $dbh->errstr()\n";
    }
}


sub setServices {
  my $this = shift @_;

  my $id_user = shift @_;
  my $name = shift @_;
  my $email = shift @_;
  my $phone = shift @_;
  my $car = shift @_;
  my $plate = shift @_;
  my $date = shift @_;
  
  $this->{'id_user'} = $id_user;
  $this->{'username'} = $name;
  $this->{'email'} = $email;
  $this->{'phone'} = $phone;
  $this->{'car'} = $car;
  $this->{'plate'} = $plate;
  $this->{'date'} = $date;
  
}



sub setBook {
  my $this = shift @_;

  my $id_service = shift @_;
  my $id_user = shift @_;
  my $name = shift @_;
  my $email = shift @_;
  my $phone = shift @_;
  my $car = shift @_;
  my $plate = shift @_;
  my $date = shift @_;

  $this->{'id_service'} = $id_service; 
  $this->{'id_user'} = $id_user;
  $this->{'username'} = $name;
  $this->{'email'} = $email;
  $this->{'phone'} = $phone;
  $this->{'car'} = $car;
  $this->{'plate'} = $plate;
  $this->{'date'} = $date;

}


sub createServss {
    my $this = shift @_;
    my $dbh = shift @_;
    my $sth = undef;

    # Check if id_user is set
    unless (defined $this->{'id_user'}) {
        die "Error: id_user is not set\n";
    }

    # Include id_user in the INSERT statement
    if ($sth = $dbh->prepare('INSERT INTO services (id_user, name, email, phone, car, plate, date) VALUES (?, ?, ?, ?, ?, ?, ?)')) {
        if ($sth->execute($this->{'id_user'}, $this->{'username'}, $this->{'email'}, $this->{'phone'}, $this->{'car'}, $this->{'plate'}, $this->{'date'})) {
            print "Success create new services...\n";
        } else {
            print "Error: " . $dbh->errstr . "\n";
        }
    } else {
        print "Error: " . $dbh->errstr . "\n";
    }
}


sub createBook {
    my $this = shift @_;
    my $dbh = shift @_;
    my $sth = undef;

    # Include id_user in the INSERT statement
    if ($sth = $dbh->prepare('INSERT INTO booking (id_service, id_user, name, email, phone, car, plate, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)')) {
        if ($sth->execute($this->{'id_service'}, $this->{'id_user'}, $this->{'username'}, $this->{'email'}, $this->{'phone'}, $this->{'car'}, $this->{'plate'}, $this->{'date'})) {
            print "Success create new services...\n";
        } else {
            print "Error: " . $dbh->errstr . "\n";
        }
    } else {
        print "Error: " . $dbh->errstr . "\n";
    }
}




sub readServsx {
    my $this = shift @_;
    my $dbh = shift @_;
    my $id_user = shift @_;
    my $sth = undef;

    if ($id_user eq "") {
        if ($sth = $dbh->prepare('SELECT * FROM booking')) {
            if ($sth->execute()) {
                my @rows = ();

                while (my $ref = $sth->fetchrow_hashref()) {
                    push(@rows, $ref);
                }

                return JSON->new->pretty->encode(\@rows);

            } else {
                print "Error: " . $dbh->errstr() . "\n";
            }
        } else {
            print "Error: " . $dbh->errstr() . "\n";
        }
    } else {
        if ($sth = $dbh->prepare('SELECT * FROM booking WHERE id_user=?')) {
            if ($sth->execute($id_user)) {
                my @rows = ();

                while (my $ref = $sth->fetchrow_hashref()) {
                    push(@rows, $ref);
                }

                return JSON->new->pretty->encode(\@rows);

            } else {
                print "Error: " . $dbh->errstr() . "\n";
            }
        } else {
            print "Error: " . $dbh->errstr() . "\n";
        }
    }
}




sub readAllServs {
    my $this = shift @_;
    my $dbh = shift @_;
    my $sth = undef;

    if ($sth = $dbh->prepare('SELECT * FROM services')) {
        if ($sth->execute()) {
            my @rows = ();

            while (my $ref = $sth->fetchrow_hashref()) {
                push(@rows, $ref);
            }

            return JSON->new->pretty->encode(\@rows);

        } else {
            print "Error: " . $dbh->errstr() . "\n";
        }
    } else {
        print "Error: " . $dbh->errstr() . "\n";
    }
}





return 1;






