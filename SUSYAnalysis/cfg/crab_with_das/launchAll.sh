:
PROD_LABEL="mAODv2_v0"  
REMOTE_DIR_DATA="8011_${PROD_LABEL}/Data25ns"
REMOTE_DIR_MC="8011_${PROD_LABEL}/RunIISpring16MiniAODv2"
#REMOTE_DIR_DATA="8011/Data25ns"
#REMOTE_DIR_MC="8011/RunIISpring16MiniAODv2"

echo --------------------------------------------
echo 
echo $PROD_LABEL
echo $REMOTE_DIR_DATA
echo $REMOTE_DIR_MC
echo
echo --------------------------------------------


data=false
w=false
tt=false
z=false
qcd=false
sig=false
dy=false
qcdpt=false
st=false
scan=false



for i in "$@"
do
case $i in
    sig)
    sig=true
    echo Will Process Priv Signals:  $sig 
    shift
    ;;
    scan)
    scan=true
    echo Will Process Official Signals:  $scan 
    shift
    ;;

    data)
    data=true
    echo Will Process Data:  $data 
    shift
    ;;

    w)
    w=true
    echo Will Process WJets:  $w
    shift
    ;;

    tt)
    tt=true
    echo Will Process TTJets:  $tt
    shift
    ;;

    qcd)
    qcd=true
    echo Will Process QCD:  $qcd
    shift
    ;;

    z)
    z=true
    echo Will Process ZJets:  $z
    shift
    ;;

    dy)
    dy=true
    echo Will Process DYJets:  $dy
    shift
    ;;

    st)
    st=true
    echo Will Process Other Tops:  $st 
    shift
    ;;

    qcdpt)
    qcdpt=true
    echo Will Process QCD pt:  $qcdpt 
    shift
    ;;
esac
done





if $data
then
  #python launch.py --unitsPerJob=1 --remoteDir=$REMOTE_DIR_DATA --production_label=$PROD_LABEL       MET_Run2015D_v4  MET_Run2015D_05Oct SingleMuon_Run2015D_v4  SingleMuon_Run2015D_05Oct SingleElectron_Run2015D_05Oct  SingleElectron_Run2015D_v4  
  echo ----------------------  Submitting DATA  ------ -----------------
  # fixed for 80x
  python launch.py --unitsPerJob=50 --remoteDir=$REMOTE_DIR_DATA --production_label=$PROD_LABEL      SingleMuon_Run2016B_PromptReco_v2     MET_Run2016B_PromptReco_v2  SingleElectron_Run2016B_PromptReco_v2
fi

if  $tt
then
  echo ----------------------  Submitting TTJets  -----------------------
  ## still missing some for 80x
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL   TTJets_LO  TTJets_LO_HT600to800_ext  TTJets_LO_HT800to1200_ext   TTJets_LO_HT1200to2500_ext TTJets_LO_HT2500toInf  #  TTJets_LO_HT600to800  TTJets_LO_HT800to1200   TTJets_LO_HT1200to2500  
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL TTJets_SingleLeptonFromT TTJets_SingleLeptonFromTbar TTJets_DiLepton    
fi

if  $w
then
  echo ----------------------  Submitting WJets  -----------------------
  # fixed for 80x
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL   WJetsToLNu_LO  WJetsToLNu_HT100to200  WJetsToLNu_HT100to200_ext WJetsToLNu_HT200to400  WJetsToLNu_HT200to400_ext  WJetsToLNu_HT400to600 WJetsToLNu_HT600to800 WJetsToLNu_HT800to1200 WJetsToLNu_HT800to1200_ext WJetsToLNu_HT1200to2500 WJetsToLNu_HT2500toInf #WJetsToLNu_HT100to200 WJetsToLNu_HT200to400 WJetsToLNu_HT400to600 WJetsToLNu_HT600toInf  WJetsToLNu_HT600to800 WJetsToLNu_HT800to1200 WJetsToLNu_HT1200to2500 WJetsToLNu_HT2500toInf    
  #old python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL   WJetsToLNu_LO  WJetsToLNu_HT100to200 WJetsToLNu_HT200to400 WJetsToLNu_HT400to600 WJetsToLNu_HT600toInf  WJetsToLNu_HT600to800 WJetsToLNu_HT800to1200 WJetsToLNu_HT1200to2500 WJetsToLNu_HT2500toInf    
fi

if  $z
then
  echo ----------------------  Submitting ZJets  -----------------------
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL   ZJetsToNuNu_HT100to200  ZJetsToNuNu_HT200to400  ZJetsToNuNu_HT400to600  ZJetsToNuNu_HT600toInf     
fi

if  $qcd
then
  echo ----------------------  Submitting QCD  -----------------------
  #python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  QCD_HT100to200 QCD_HT200to300  QCD_HT300to500  QCD_HT500to700 QCD_HT700to1000 QCD_HT1000to1500  QCD_HT1500to2000  QCD_HT2000toInf  

  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  QCD_HT300to500  QCD_HT300to500_ext QCD_HT500to700_ext  QCD_HT700to1000  QCD_HT700to1000_ext  QCD_HT1000to1500  QCD_HT1000to1500_ext  QCD_HT1500to2000  QCD_HT1500to2000_ext  QCD_HT2000toInf  QCD_HT2000toInf_ext
#QCD_HT500to700,
fi

if  $sig
then
  echo ----------------------  Submitting Priv Signal  -----------------------
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="phys03" T2DegStop_300_290_FastSim   T2DegStop_300_240_FastSim   T2DegStop_300_270_FastSim  T2tt_300_270_FastSim   
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="phys03"    T2DegStop_300_270
fi

if  $scan
then
  echo ------------------------------- Signal Mass Scan -----------------
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  SMS_T2_4bd_mStop_100_mLSP_20to90  SMS_T2_4bd_mStop_125_mLSP_45to115      SMS_T2_4bd_mStop_150_mLSP_45to115      SMS_T2_4bd_mStop_175_mLSP_95to165      SMS_T2_4bd_mStop_200_mLSP_120to190     SMS_T2_4bd_mStop_225_mLSP_145to225     SMS_T2_4bd_mStop_250_mLSP_170to240     SMS_T2_4bd_mStop_275_mLSP_195to265      SMS_T2_4bd_mStop_300_mLSP_220to290     SMS_T2_4bd_mStop_325_mLSP_245to315     SMS_T2_4bd_mStop_350_mLSP_270to340     SMS_T2_4bd_mStop_375_mLSP_295to365     SMS_T2_4bd_mStop_400_mLSP_320to390     SMS_T2_4bd_mStop_425to475_mLSP_345to465 SMS_T2_4bd_mStop_500to550_mLSP_420to540  SMS_T2_4bd_mStop_550to600_mLSP_470to590 
fi

if  $st
then
  echo ----------------------  Submitting Other Tops  -----------------------
  #python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL TToLeptons_tch_amcatnlo  TToLeptons_tch_amcatnlo_ext   TToLeptons_sch_amcatnlo  TBar_tWch  T_tWch  T_tWch_DS  TBar_tWch_DS  tZq_ll  tZq_nunu
fi

if  $qcdpt
then
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  QCD_Pt15to20_EMEnriched QCD_Pt20to30_EMEnriched QCD_Pt30to50_EMEnriched QCD_Pt50to80_EMEnriched QCD_Pt80to120_EMEnriched  QCD_Pt120to170_EMEnriched  QCD_Pt170to300_EMEnriched  QCD_Pt300toInf_EMEnriched  QCD_Pt15to20_Mu5  QCD_Pt20to30_Mu5  QCD_Pt50to80_Mu5 QCD_Pt80to120_Mu5   QCD_Pt120to170_Mu5   QCD_Pt300to470_Mu5  QCD_Pt470to600_Mu5  QCD_Pt600to800_Mu5  QCD_Pt800to1000_Mu5  QCD_Pt1000toInf_Mu5  QCD_Pt10to15  QCD_Pt15to30  QCD_Pt30to50  QCD_Pt50to80  QCD_Pt80to120  QCD_Pt120to170  QCD_Pt170to300  QCD_Pt300to470  QCD_Pt470to600  QCD_Pt600to800  QCD_Pt800to1000  QCD_Pt1000to1400  QCD_Pt1400to1800  QCD_Pt1800to2400  QCD_Pt2400to3200  QCD_Pt3200toInf QCD_Pt30to50_Mu5
fi

if  $dy
then
  echo ----------------------  Submitting DY  -----------------------
  python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL   DYJetsToLL_M50_HT100to200_ext DYJetsToLL_M50_HT200to400_ext  DYJetsToLL_M50_HT400to600_ext  DYJetsToLL_M50_HT600toInf  DYJetsToLL_M50_HT600toInf_ext
  #python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  DYJetsToLL_M5to50_LO         DYJetsToNuNu_M50  
  #python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  DYJetsToLL_M5to50_HT100to200 DYJetsToLL_M5to50_HT200to400  DYJetsToLL_M5to50_HT400to600  DYJetsToLL_M5to50_HT600toInf 
  #python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  DYJetsToLL_M50_HT100to200    DYJetsToLL_M50_HT200to400     DYJetsToLL_M50_HT400to600     DYJetsToLL_M50_HT600toInf  
fi
#DYJetsToLL_M50_HT100to200,
#DYJetsToLL_M50_HT200to400,


#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  TTJets_LO_HT2500toInf QCD_HT500to700 QCD_HT700to1000 QCD_HT1000to1500  

 #
 #
 #
 #
##python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL QCD_Pt300toInf_EMEnriched  QCD_Pt30to50_EMEnriched  QCD_Pt120to170_EMEnriched QCD_Pt30to50_Mu5  QCD_Pt120to170_Mu5  QCD_Pt470to600_Mu5  QCD_Pt600to800_Mu5 QCD_Pt3200toInfQCD_Pt3200toInf 
 #
 #
 #
##python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL QCD_Pt300toInf_EMEnriched  QCD_Pt30to50_EMEnriched  QCD_Pt120to170_EMEnriched 
 #
 #
 #
 #
 #
 #
 #
 #
##python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  QCD_Pt300toInf_EMEnriched   #QCD_Pt5to10 #QCD_Pt3200toInf
 #
 #
 #
 #
##
##
## 
##
##
 #


#
#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL DYJetsToLL_M5to50_HT200to400
###FASTSIM
#export ISDATA=FALSE






#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="global"  SMS_T2_4bd_mStop_100_mLSP_20to90    SMS_T2_4bd_mStop_250_mLSP_170to240  




#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL  QCD_HT300to500  QCD_HT1000to1500   TTJets_LO_HT800to1200  WJetsToLNu_HT100to200 WJetsToLNu_HT800to1200 WJetsToLNu_HT1200to2500 ZJetsToNuNu_HT200to400  

#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL SMS_T2_4bd_mStop_150_mLSP_45to115 SMS_T2_4bd_mStop_500to550_mLSP_470to590

###########################

#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="global"    SMS_T2_4bd_mStop_125_mLSP_45to115           SMS_T2_4bd_mStop_225_mLSP_145to225       SMS_T2_4bd_mStop_425to475_mLSP_345to465  SMS_T2_4bd_mStop_550to600_mLSP_470to590 
#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="global"     SMS_T2_4bd_mStop_425to475_mLSP_345to465  

#export ISDATA=TRUE
#python launch.py --unitsPerJob=1 --remoteDir=$REMOTE_DIR_DATA --production_label=$PROD_LABEL   MET_Run2015D_v4  SingleMuon_Run2015D_v4 SingleElectron_Run2015D_v4   
#export ISDATA=FALSE
#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL    TTJets_LO   TTJets_SingleLeptonFromT TTJets_DiLepton   
#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL    WJetsToLNu_HT200to400   WJetsToLNu_HT-600To800  
#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL    ZJetsToNuNu_HT600toInf     
#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL    QCD_HT200to300  QCD_HT300to500  QCD_HT500to700   QCD_HT2000toInf  
##python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="phys03"   T2DegStop_300_270
#
####FASTSIM
#export ISDATA=FALSE
###python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="phys03" T2DegStop_300_290_FastSim   T2DegStop_300_240_FastSim   T2DegStop_300_270_FastSim  T2tt_300_270_FastSim   &
#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="global"   SMS_T2_4bd_mStop_100_mLSP_20to90    SMS_T2_4bd_mStop_125_mLSP_45to115   SMS_T2_4bd_mStop_550to600_mLSP_470to590  
##python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL --inputDBS="global" SMS_T2mixed_mStop_175_mLSP_95to165  



#python launch.py  --unitsPerJob=1 --remoteDir=$REMOTE_DIR_MC --production_label=$PROD_LABEL   WJetsToLNu_HT600to800  


