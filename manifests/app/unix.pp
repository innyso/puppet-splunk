class splunk::app::unix {

  $apppath = '/opt/splunk/etc/apps/unix/local'

  package {'splunk-unix':
    ensure   => installed,
    provider => yum,
  }
  file {
    # Start UNIX App
    '/opt/splunk/etc/apps/unix/local':
      ensure  => 'directory',
      owner   => 'splunk',
      group   => 'splunk';

    'unix-app.conf':
      ensure  => 'present',
      path    => "$apppath/app.conf",
      owner   => 'splunk',
      group   => 'splunk',
      mode    => '0644',
      content => template("splunk$apppath/app.conf.erb");

    'unix-inputs.conf':
      ensure  => 'present',
      path    => "$apppath/inputs.conf",
      owner   => 'splunk',
      group   => 'splunk',
      mode    => '0644',
      notify  => Class['splunk::service'],
      content => template("splunk$apppath/inputs.conf.erb"),
  }
}
