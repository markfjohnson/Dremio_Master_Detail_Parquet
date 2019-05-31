import subprocess

master_ip_list=subprocess.Popen("terraform output master_public_ip", shell=True, stdout=subprocess.PIPE).stdout.read()
master_pri_ip_list=subprocess.Popen("terraform output master_private_ip", shell=True, stdout=subprocess.PIPE).stdout.read()
master_dns_list=subprocess.Popen("terraform output master_private_dns", shell=True, stdout=subprocess.PIPE).stdout.read()

ambari_ip_list=subprocess.Popen("terraform output ambari_public_ip", shell=True, stdout=subprocess.PIPE).stdout.read()
ambari_pri_ip_list=subprocess.Popen("terraform output ambari_private_ip", shell=True, stdout=subprocess.PIPE).stdout.read()
ambari_dns_list=subprocess.Popen("terraform output ambari_private_dns", shell=True, stdout=subprocess.PIPE).stdout.read()

#hdp_master_ip_list=subprocess.Popen("terraform output hdp_master_public_ip", shell=True, stdout=subprocess.PIPE).stdout.read()
#hdp_master_pri_ip_list=subprocess.Popen("terraform output hdp_master_private_ip", shell=True, stdout=subprocess.PIPE).stdout.read()
#hdp_master_dns_list=subprocess.Popen("terraform output hdp_master_private_dns", shell=True, stdout=subprocess.PIPE).stdout.read()

hdp_agent_ip_list=subprocess.Popen("terraform output hdp_agent_public_ip", shell=True, stdout=subprocess.PIPE).stdout.read()
hdp_agent_pri_ip_list=subprocess.Popen("terraform output hdp_agent_private_ip", shell=True, stdout=subprocess.PIPE).stdout.read()
hdp_agent_dns_list=subprocess.Popen("terraform output hdp_agent_private_dns", shell=True, stdout=subprocess.PIPE).stdout.read()

master_ip = master_ip_list.replace('\n','').split(",")
master_pri_ip = master_pri_ip_list.replace('\n','').split(",")
master_dns = master_dns_list.replace('\n','').split(",")

ambari_ip = ambari_ip_list.replace('\n','').split(",")
ambari_pri_ip = ambari_pri_ip_list.replace('\n','').split(",")
ambari_dns = ambari_dns_list.replace('\n','').split(",")

#hdp_master_ip = hdp_master_ip_list.replace('\n','').split(",")
#hdp_master_pri_ip = hdp_master_pri_ip_list.replace('\n','').split(",")
#hdp_master_dns = hdp_master_dns_list.replace('\n','').split(",")

hdp_agent_ip = hdp_agent_ip_list.replace('\n','').split(",")
hdp_agent_pri_ip = hdp_agent_pri_ip_list.replace('\n','').split(",")
hdp_agent_dns = hdp_agent_dns_list.replace('\n','').split(",")

all_ip = list(master_ip)
#all_ip.extend(ambari_ip)
#all_ip.extend(hdp_master_ip)
#all_ip.extend(hdp_agent_ip)

all_pri_ip = list(master_pri_ip)
#all_pri_ip.extend(ambari_pri_ip)
#all_pri_ip.extend(hdp_master_pri_ip)
#all_pri_ip.extend(hdp_agent_pri_ip)


#
#### Create the Ansible Hosts file
f = open("dremio_hosts","w")
i=0
f.write("[all]\n")
for a in all_ip:
    i = i+1
    f.write(a+"  "+' ansible_connection=ssh        ansible_user=centos ansible_ssh_private_key_file=westncal.pem'+"\n")

f.write('\n\n[master]\n')
i=0
for a in master_ip:
    host_name = master_dns[i]
    i = i+1
    f.write(a+"  "+' ansible_connection=ssh        ansible_user=centos ansible_ssh_private_key_file=westncal.pem'+"\n")
f.write("\n\n")

# f.write("[ambari]\n")
# i=0
# for a in ambari_ip:
#     i = i+1
#     f.write(a+"  "+' ansible_connection=ssh        ansible_user=centos ansible_ssh_private_key_file=westncal.pem'+"\n")
#
# f.write("\n\n[hdp_agent]\n")
# i = 0
# for h in hdp_agent_ip:
#     i = i+1
#     f.write( h +"  "+' ansible_connection=ssh        ansible_user=centos ansible_ssh_private_key_file=westncal.pem'+"\n")

# f.write("\n\n[hdp_master]\n")
# i = 0
# for h in hdp_master_ip:
#     i = i+1
#     f.write( h +"  "+' ansible_connection=ssh        ansible_user=centos ansible_ssh_private_key_file=westncal.pem'+"\n")

# Masters
f.write
f.close()


#
# Create the OS Hosts file
f = open("hosts","w")

f.write("127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4\n")
#f.write("::1         localhost localhost.localdomain localhost6 localhost6.localdomain6\n\n")
# f.write("\n# Ambari\n")
# i = 0
# for a in ambari_pri_ip:
#     host_name = ambari_dns[i]
#     i = i+1
#     f.write(a+"  "+host_name+"\n")

f.write("\n\n# Dremio Master\n")
i=0
for a in master_pri_ip:
    host_name = master_dns[i]
    i = i+1
    f.write(a+"  "+host_name+"\n")

f.write("\n\n")
# f.write("# HDP Agents\n")
# i = 0
# for h in hdp_agent_pri_ip:
#     host_name = hdp_agent_dns[i]
#     i = i+1
#     f.write( h +"  "+host_name+"\n")
# f.write("\n\n")

# f.write(" HDP Masters\n")
# i = 0
# for h in hdp_master_pri_ip:
#      host_name = hdp_master_dns[i]
#      i = i+1
#      f.write( h +"  "+host_name+"\n")
# f.write("\n\n")
# f.close()

## Prepare the Blueprint nodes
# f = open("ambari_nodes.json","w")
# f.write(" { \"blueprint\" : \"hdp_blueprint\",\n\"default_password\" : \"admin\",\n\"host_groups\" :[\n")
# group_id = 1
#

# first_row = True
# for h in hdp_master_pri_ip:
#     if not first_row:
#         f.write(",\n        ")
#     f.write("    {{\n      \"name\": \"host_group_{}\",\n      \"hosts\":[ \n".format(group_id))
#     f.write("        {{\"fqdn\":\"{}\"}}\n    ]\n   }}".format(h))
#     first_row = False
#     group_id = group_id + 1
#
# f.write(",")


# first_row = True
# for h in hdp_agent_pri_ip:
#     if not first_row:
#         f.write(",\n        ")
#     f.write("    {{\n      \"name\": \"host_group_{}\",\n      \"hosts\":[ \n".format(group_id))
#
#     f.write("        {{\"fqdn\":\"{}\"}}\n    ]\n   }}".format(h))
#     first_row = False
#     group_id = group_id + 1
#
#
# f.write("\n   ]\n}")