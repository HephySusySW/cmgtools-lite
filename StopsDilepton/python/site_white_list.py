import subprocess
import json

#/afs/cern.ch/user/v/valya/public/dasgoclient/dasgoclient_linux --query "site dataset=/JetHT/Run2016B-03Feb2017_ver2-v2/MINIAOD"

#das_client = "das_client.py"
das_client = "/afs/cern.ch/user/v/valya/public/dasgoclient/dasgoclient_linux"


def site_white_list( dataset ):
    '''Get all sites where a dataset is stored from DAS
    '''
    query='site dataset=%s'%dataset
    #print "das_client.py", "--format=json", "--limit=0", "--query='%s'"%query
    #p = subprocess.Popen(["das_client.py", "--format=plain", "--limit=0", "--query='%s'"%query], shell = True , stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    #txt = subprocess.check_output(["das_client.py", "--format=json", "--limit=0", "--query=%s"%query])
    print das_client, "--json", "--query=%s"%query
    txt = subprocess.check_output([das_client, "--json", "--query=%s"%query])
    data = json.loads(txt)
    #return data
    return list(set([str(s['site'][0]['name']) for s in data])) 
#    return [str(d['site'][0]['name']) for d in data['data']]
#    res=[]
#    for line in p.stdout.readlines():
#            line = line[:-1]
#            print line
#            if line.startswith("T") and len(line.split("_"))>=3:
#                res.append( line )
#    return res

if __name__ == "__main__":
   dataset = "/DoubleMuon/Run2016E-23Sep2016-v1/MINIAOD"
   sites = site_white_list( dataset )
   print sites
