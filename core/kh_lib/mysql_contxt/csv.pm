package mysql_contxt::csv;
use base qw(mysql_contxt);
use strict;

#---------------------#
#   1行目を付け足す   #

sub _save_finish{
	my $self = shift;
	
	my $first_line = '抽出語,';
	foreach my $w2 (@{$self->{wList2}}){
		$first_line .= "cw: $self->{wName2}{$w2},";
	}
	chop $first_line;
	$first_line = Jcode->new($first_line)->sjis;
	
	my $file = $self->data_file;
	my $file_tmp = "$file".".bak";
	
	open (OLD,"$file") or 
		gui_errormsg->open(
			type    => 'file',
			thefile => "$file",
		);
	open (NEW,">$file_tmp") or
		gui_errormsg->open(
			type    => 'file',
			thefile => "$file_tmp",
		);
	print NEW "$first_line\n";
	while (<OLD>){
		print NEW $_;
	}
	close (NEW);
	close (OLD);
	unlink($file);
	rename($file_tmp,$file);
}

#--------------#
#   アクセサ   #
#--------------#

sub data_file{
	my $self = shift;
	return $self->{file_save};
}


1;