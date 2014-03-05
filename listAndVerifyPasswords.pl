#!/usr/bin/perl -w

# listAndVerifyPasswords.pl

####  YOU SHOLD REDEFINE THESE VARIABLES !!!

my $CGServerAddress='127.0.0.1';  #IP or domain name;
my $Login='postmaster';
my $Password='pass';

#### end of the customizeable variables list


use CLI;  #get one from www.stalker.com/CGPerl/
use strict;



my $cli = new CGP::CLI( { PeerAddr => $CGServerAddress,
                          PeerPort => 106,
                          login    => $Login,
                          password => $Password } )
   || die "Can't login to CGPro: ".$CGP::ERR_STRING."\n";


processAllDomains();
#processDomain('company.com');
#processAccount('user@company.com');


$cli->Logout();

exit;


sub processAllDomains {
  my $DomainList = $cli->ListDomains()
               || die "*** Can't get the domain list: ".$cli->getErrMessage.", quitting";
  foreach(@$DomainList) {
    processDomain($_);
  }
}         


sub processDomain {
  my $domain=$_[0];
#  print "Domain: $domain\n";

  my $cookie="";
  do {
    my $data=$cli->ListDomainObjects($domain,5000,undef,'ACCOUNTS',$cookie);
    unless($data) {
      print "*** Can't get accounts for $domain: ".$cli->getErrMessage."\n";
      return;
    }
    $cookie=$data->[4];
    foreach(keys %{$data->[1]} ) {
      processAccount("$_\@$domain"); 
    }
  }while($cookie ne '');
 
}



sub processAccount {
  my ($Account)=@_;
  my $accountPassword='???';
  my $verifyPass='';
  if($cli->SendCommand("getaccountplainpassword $Account")) {
    if($cli->{errCode} eq 201) {
      $accountPassword=$cli->GetResponseData();

      $verifyPass=$cli->VerifyAccountPassword("$Account","$accountPassword") ? "correct" : "wrong";
    }
  }
  print "$Account\t$accountPassword\t$verifyPass\n";
}


__END__

