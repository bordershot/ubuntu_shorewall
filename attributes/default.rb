#default['shorewall']['enabled'] = false
#default['shorewall']['enabled'] = true

#default['shorewall']['default']['options'] = ""
#default['shorewall']['default']['wait_interface'] = false
#default['shorewall']['default']['startoptions'] = ""
#default['shorewall']['default']['restartoptions'] = ""
#default['shorewall']['default']['initlog'] = "/dev/null"
#default['shorewall']['default']['safestop'] = 0

#default['shorewall']['zones'] = [ ]
#default['shorewall']['policy'] = [ ]
#default['shorewall']['interfaces'] = [ ]
#default['shorewall']['hosts'] = [ ]
#default['shorewall']['rules'] = [ ]
#default['shorewall']['zones'] = [ ]
#default['shorewall']['tunnels'] = [ ]
#default['shorewall']['masq'] = []


default[:shorewall][:zones] = [
    { :zone => "fw", :type => "firewall" },
    { :zone => "net", :type => "ipv4" }
  ]

default[:shorewall][:policy] = [
    { :source => "$FW", :dest => "all", :policy => "ACCEPT" },
    { :source => "net", :dest => "all", :policy => "DROP", :log => "INFO" }
  ]

default[:shorewall][:interfaces] = [
    { :zone => "-", :interface => "lo", :broadcast => "detect", :options => "ignore" },
    { :zone => "net", :interface => "all", :broadcast => "detect", :options => "dhcp,physical=+,routeback,optional" }
#"tcpflags,nosmurfs,routefilter,logmartians" }
  ]

default[:shorewall][:rules]= [
    {
      :description => "Don't allow connection pickup from the net",
      :action => "Invalid(DROP)", :source => "net", :dest => "$FW"
    },
    {
      :description => "Accept DNS connections from the firewall to the network",
      :action => "SSH(ACCEPT)", :source => "net", :dest => "$FW"
    },
    {
      :description => "Accept NTP connections from the firewall to the network",
      :action => "NTP(ACCEPT)", :source => "net", :dest => "$FW"
    },
    {
      :description => "Accept NTP connections from the network to the firewall",
      :action => "Ping(ACCEPT)", :source => "net", :dest => "$FW"
    },
    {
      :description => "Accept HTTP/HTTPS connections from network to the firewall",
      :action => "Web(ACCEPT)", :source => "net", :dest => "$FW"
    },
    { 
      :description => "Plex Web App from network to the firewall", 
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => 32400, :action => "ACCEPT" 
    },
    {                                                                                                            
      :description => "Plex DLNA from network to the firewall",                                               
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => 1900, :action => "ACCEPT"                
    },
    {                                                                                                            
      :description => "Plex Companion from network to the firewall",                                               
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => 3005, :action => "ACCEPT"                
    },
    {                                                                                                            
      :description => "Plex Bonjour from network to the firewall",                                               
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => 5353, :action => "ACCEPT"                
    },
    {                                                                                                            
      :description => "Plex DLNA from network to the firewall",                                               
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => 32469, :action => "ACCEPT"                
    },
    {                                                                                                            
      :description => "Plex GDM Network Discovery from network to the firewall",                                               
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "32410:32414", :action => "ACCEPT"                
    },
    {
      :description => "Squid Redirect",
      :source => "net:!192.168.37.190", :dest => "3128", :proto => "tcp", :dest_port => "80", :action => "REDIRECT"
    },
    {
      :description => "NFS rpc.mountd rpc.statd rpc.quotad rpc.lockd https://wiki.debian.org/SecuringNFS",
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "32764:32769", :action => "ACCEPT"
    },
    {
      :description => "NFS rpc.mountd rpc.statd rpc.quotad rpc.lockd",
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "32764:32769", :action => "ACCEPT"
    },
#    {
#      :description => "NFS lock manager",
#      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "4045", :action => "ACCEPT"
#    },
#    {
#      :description => "NFS lock manager",
#      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "4045", :action => "ACCEPT"
#    },
    {
      :description => "NFS Cluster and Client",
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "1110", :action => "ACCEPT"
    },
    {
      :description => "NFS Cluster and Client",                                                                            
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "1110", :action => "ACCEPT"
    },
    {
      :description => "NFS probably",                                                                            
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "2049", :action => "ACCEPT"
    },
    {
      :description => "NFS probably",
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "2049", :action => "ACCEPT"
    },
    {
      :description => "NFS probably",                                                                            
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "111", :action => "ACCEPT"
    },
    {
      :description => "NFS probably",                                                                            
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "111", :action => "ACCEPT"
    },
    {
      :description => "rsyslog",
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "514", :action => "ACCEPT"
    },
    {
      :description => "grafana",
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "3000", :action => "ACCEPT"
    },
    {
      :description => "Samba",
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "137:138", :action => "ACCEPT"
    },
    {
      :description => "Samba",
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "139", :action => "ACCEPT"
    },
    {
      :description => "Samba",
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "445", :action => "ACCEPT"
    },

#    {
#      :description => "Unknown",
#      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "39646", :action => "ACCEPT"
#    },
    {
      :description => "Carbon",
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "2003", :action => "ACCEPT"
    },
    {
      :description => "Carbon",
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "2003", :action => "ACCEPT"
    },
    {
      :description => "Collectd",
      :source => "net", :dest => "$FW", :proto => "tcp", :dest_port => "25826", :action => "ACCEPT"
    },
    {                                                                                                            
      :description => "Collectd",
      :source => "net", :dest => "$FW", :proto => "udp", :dest_port => "25826", :action => "ACCEPT"
    },


#    {
#      :description => "Drop Ping from the \"bad\" net zone.. and prevent your log from being flooded..",
#      :action => "Ping(DROP)", :source => "net", :dest => "fw"
#    },
#    {
#      :description => "Drop Ping from the \"bad\" net zone.. and prevent your log from being flooded..",
#      :action => "ACCEPT", :source => "fw", :dest => "loc", :proto => "icmp"
#    },
#    {
#      :description => "Drop Ping from the \"bad\" net zone.. and prevent your log from being flooded..",
#      :action => "ACCEPT", :source => "fw", :dest => "net", :proto => "icmp"
#    }
  ]

