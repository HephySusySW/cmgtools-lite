def _ttH_idEmu_cuts_E2(lep):
    if (abs(lep.pdgId)!=11): return True
    if (lep.hadronicOverEm>=(0.10-0.03*(abs(lep.etaSc)>1.479))): return False
    if (abs(lep.dEtaScTrkIn)>=(0.01-0.002*(abs(lep.etaSc)>1.479))): return False
    if (abs(lep.dPhiScTrkIn)>=(0.04+0.03*(abs(lep.etaSc)>1.479))): return False
    if (lep.eInvMinusPInv<=-0.05): return False
    if (lep.eInvMinusPInv>=(0.01-0.005*(abs(lep.etaSc)>1.479))): return False
    if (lep.sigmaIEtaIEta>=(0.011+0.019*(abs(lep.etaSc)>1.479))): return False
    return True
def _ttH_idEmu_cuts_E2_obj(lep):
    if (abs(lep.pdgId())!=11): return True
    etasc = lep.superCluster().eta()
    if (lep.hadronicOverEm()>=(0.10-0.03*(abs(etasc)>1.479))): return False
    if (abs(lep.deltaEtaSuperClusterTrackAtVtx())>=(0.01-0.002*(abs(etasc)>1.479))): return False
    if (abs(lep.deltaPhiSuperClusterTrackAtVtx())>=(0.04+0.03*(abs(etasc)>1.479))): return False
    eInvMinusPInv = (1.0/lep.ecalEnergy() - lep.eSuperClusterOverP()/lep.ecalEnergy()) if lep.ecalEnergy()>0. else 9e9
    if (eInvMinusPInv<=-0.05): return False
    if (eInvMinusPInv>=(0.01-0.005*(abs(etasc)>1.479))): return False
    if (lep.full5x5_sigmaIetaIeta()>=(0.011+0.019*(abs(etasc)>1.479))): return False
    return True

def _soft_MuonId_2016ICHEP(lep):
    if (abs(lep.pdgId())!=13): return False
    if not lep.muonID("TMOneStationTight"): return False #TMOneStationTightMuonId
    if not lep.track().hitPattern().trackerLayersWithMeasurement() > 5: return False
    if not lep.track().hitPattern().pixelLayersWithMeasurement() > 0: return False
    if not (abs(lep.dxy())<0.3 and abs(lep.dz())<20): return False
    return True

def _medium_MuonId_2016ICHEP(lep):
    if (abs(lep.pdgId())!=13): return False
    if not (lep.physObj.isGlobalMuon() or lep.physObj.isTrackerMuon()): return False
    if not (lep.innerTrack().validFraction()>0.49): return False
    if lep.segmentCompatibility()>0.451: return True
    else:
        if not lep.globalTrack().isNonnull(): return False
        if not lep.isGlobalMuon: return False
        if not lep.globalTrack().normalizedChi2()<3: return False
        if not lep.combinedQuality().chi2LocalPosition<12: return False
        if not lep.combinedQuality().trkKink<20: return False 
        if not lep.segmentCompatibility()>0.303: return False

    return True


from CMGTools.TTHAnalysis.tools.leptonJetReCleaner import LeptonJetReCleaner
from CMGTools.TTHAnalysis.tools.conept import conept_TTH

MODULES=[]
#MODULES.append( ('leptonJetReCleanerTTH', lambda : LeptonJetReCleaner("Recl", # b1E2 definition of FO, 80X b-tag WP for Spring16
#                   looseLeptonSel = lambda lep : lep.miniRelIso < 0.4 and lep.sip3d < 8,
#                   cleaningLeptonSel = lambda lep : lep.conept>10 and lep.jetBTagCSV<0.8484 and (abs(lep.pdgId)!=11 or lep.conept<30 or _ttH_idEmu_cuts_E2(lep)) and (lep.jetPtRatiov2>0.3 or lep.mvaTTH>0.75) and ((abs(lep.pdgId)==13 and lep.jetBTagCSV<0.5426) or (abs(lep.pdgId)==11 and (lep.mvaIdSpring16GP>-0.5 or abs(lep.eta)<1.479)) or lep.mvaTTH>0.75), # cuts applied on top of loose
#                   FOLeptonSel = lambda lep,ht : lep.conept>10 and lep.jetBTagCSV<0.8484 and (abs(lep.pdgId)!=11 or lep.conept<30 or _ttH_idEmu_cuts_E2(lep)) and (lep.jetPtRatiov2>0.3 or lep.mvaTTH>0.75) and ((abs(lep.pdgId)==13 and lep.jetBTagCSV<0.5426) or (abs(lep.pdgId)==11 and (lep.mvaIdSpring16GP>-0.5 or abs(lep.eta)<1.479)) or lep.mvaTTH>0.75), # cuts applied on top of loose
#                   tightLeptonSel = lambda lep,ht : lep.conept>10 and lep.jetBTagCSV<0.8484 and (abs(lep.pdgId)!=11 or lep.conept<30 or _ttH_idEmu_cuts_E2(lep)) and (lep.jetPtRatiov2>0.3 or lep.mvaTTH>0.75) and ((abs(lep.pdgId)==13 and lep.jetBTagCSV<0.5426) or (abs(lep.pdgId)==11 and (lep.mvaIdSpring16GP>-0.5 or abs(lep.eta)<1.479)) or lep.mvaTTH>0.75) and (abs(lep.pdgId)!=13 or lep.mediumMuonId>0) and lep.mvaTTH > 0.75, # cuts applied on top of loose
#                   cleanJet = lambda lep,jet,dr : dr<0.4, # called on cleaning leptons and loose taus
#                   selectJet = lambda jet: abs(jet.eta)<2.4,
#                   cleanTau = lambda lep,tau,dr: dr<0.4,
#                   looseTau = lambda tau: tau.pt > 20 and abs(tau.eta)<2.3 and abs(tau.dxy) < 1000 and abs(tau.dz) < 0.2 and tau.idMVAdR03 >= 2 and tau.idDecayMode, # used in cleaning
#                   tightTau = lambda tau: tau.idMVAdR03 >= 3, # cuts applied on top of loose
#                   cleanJetsWithTaus = True,
#                   cleanTausWithLoose = True, # cleaning taus with cleaningLeptonSel == loose
#                   doVetoZ = True,
#                   doVetoLMf = True,
#                   doVetoLMt = True,
#                   jetPt = 40,
#                   bJetPt = 25,
#                   coneptdef = lambda lep: conept_TTH(lep) ) ))

from CMGTools.TTHAnalysis.tools.combinedObjectTaggerForCleaning import *
from CMGTools.TTHAnalysis.tools.fastCombinedObjectRecleaner import *

MODULES.append( ('leptonJetFastReCleanerTTH_step1', lambda : CombinedObjectTaggerForCleaning("InternalRecl",
                                                                                       looseLeptonSel = lambda lep : lep.miniRelIso < 0.4 and lep.sip3d < 8,
                                                                                       cleaningLeptonSel = lambda lep : lep.conept>10 and lep.jetBTagCSV<0.8484 and (abs(lep.pdgId)!=11 or lep.conept<30 or _ttH_idEmu_cuts_E2(lep)) and (lep.jetPtRatiov2>0.3 or lep.mvaTTH>0.75) and ((abs(lep.pdgId)==13 and lep.jetBTagCSV<0.5426) or (abs(lep.pdgId)==11 and (lep.mvaIdSpring16GP>-0.5 or abs(lep.eta)<1.479)) or lep.mvaTTH>0.75),
                                                                                       FOLeptonSel = lambda lep : lep.conept>10 and lep.jetBTagCSV<0.8484 and (abs(lep.pdgId)!=11 or lep.conept<30 or _ttH_idEmu_cuts_E2(lep)) and (lep.jetPtRatiov2>0.3 or lep.mvaTTH>0.75) and ((abs(lep.pdgId)==13 and lep.jetBTagCSV<0.5426) or (abs(lep.pdgId)==11 and (lep.mvaIdSpring16GP>-0.5 or abs(lep.eta)<1.479)) or lep.mvaTTH>0.75),
                                                                                       tightLeptonSel = lambda lep : lep.conept>10 and lep.jetBTagCSV<0.8484 and (abs(lep.pdgId)!=11 or lep.conept<30 or _ttH_idEmu_cuts_E2(lep)) and (lep.jetPtRatiov2>0.3 or lep.mvaTTH>0.75) and ((abs(lep.pdgId)==13 and lep.jetBTagCSV<0.5426) or (abs(lep.pdgId)==11 and (lep.mvaIdSpring16GP>-0.5 or abs(lep.eta)<1.479)) or lep.mvaTTH>0.75) and (abs(lep.pdgId)!=13 or lep.mediumMuonId>0) and lep.mvaTTH > 0.75,
                                                                                       FOTauSel = lambda tau: tau.pt > 20 and abs(tau.eta)<2.3 and abs(tau.dxy) < 1000 and abs(tau.dz) < 0.2 and tau.idMVAdR03 >=2  and tau.idDecayMode,
                                                                                       tightTauSel = lambda tau: tau.idMVAdR03 >= 3,
                                                                                       selectJet = lambda jet: abs(jet.eta)<2.4,
                                                                                       coneptdef = lambda lep: conept_TTH(lep) ) ))
MODULES.append( ('leptonJetFastReCleanerTTH_step2',lambda : fastCombinedObjectRecleaner(label="Recl",
                                                                                        inlabel="_InternalRecl",
                                                                                        cleanTausWithLooseLeptons=True,
                                                                                        cleanJetsWithFOTaus=True,
                                                                                        doVetoZ=False,
                                                                                        doVetoLMf=False,
                                                                                        doVetoLMt=False,
                                                                                        jetPts=[25,40],
                                                                                        btagL_thr=0.5426,
                                                                                        btagM_thr=0.8484) ))

from CMGTools.TTHAnalysis.tools.eventVars_2lss import EventVars2LSS
MODULES.append( ('eventVars', lambda : EventVars2LSS('','Recl')) )

from CMGTools.TTHAnalysis.tools.kinMVA_2D_2lss_3l import KinMVA_2D_2lss_3l
MODULES.append( ('kinMVA_2D_2lss_3l', lambda : KinMVA_2D_2lss_3l(os.environ["CMSSW_BASE"]+"/src/CMGTools/TTHAnalysis/data/kinMVA/tth/%s_BDTG.weights.xml", skip_BDTv8 = False, skip_MEM = True, skip_Hj=False)) )

from CMGTools.TTHAnalysis.tools.BDTv8_eventReco_cpp import BDTv8_eventReco
MODULES.append( ('BDTv8_Hj', lambda : BDTv8_eventReco(os.environ["CMSSW_BASE"]+'/src/CMGTools/TTHAnalysis/data/kinMVA/tth/TMVAClassification_bloose_BDTG.weights.xml',
                                                      os.environ["CMSSW_BASE"]+'/src/CMGTools/TTHAnalysis/data/kinMVA/tth/TMVAClassification_btight_BDTG.weights.xml',
                                                      os.environ["CMSSW_BASE"]+'/src/CMGTools/TTHAnalysis/data/kinMVA/tth/Hj_csv_BDTG.weights.xml',
                                                      os.environ["CMSSW_BASE"]+'/src/CMGTools/TTHAnalysis/data/kinMVA/tth/Hjj_csv_BDTG.weights.xml',
                                                      selection = [
                lambda leps,jets,event : len(leps)>=2 and len(jets)>=4,
                lambda leps,jets,event : leps[0].conePt>20 and leps[1].conePt>10 and leps[0].charge*leps[1].charge>0,
                ]
                                                      )) )

from CMGTools.TTHAnalysis.tools.evtTagger import EvtTagger
MODULES.append( ('Trigger_2lss', lambda : EvtTagger("Trigger_2l",[
                lambda ev : \
                    ev.HLT_BIT_HLT_Ele23_Ele12_CaloIdL_TrackIdL_IsoVL_DZ_v or \
                    ev.HLT_BIT_HLT_Ele27_WPTight_Gsf_v or \
                    ev.HLT_BIT_HLT_Ele25_eta2p1_WPTight_Gsf_v or \
                    ev.HLT_DoubleMu or \
                    ev.HLT_BIT_HLT_IsoMu24_v or \
                    ev.HLT_BIT_HLT_IsoTkMu24_v or \
                    ev.HLT_BIT_HLT_IsoMu22_eta2p1_v or \
                    ev.HLT_BIT_HLT_IsoTkMu22_eta2p1_v or \
                    ev.HLT_BIT_HLT_Mu23_TrkIsoVVL_Ele8_CaloIdL_TrackIdL_IsoVL_v or \
                    ev.HLT_BIT_HLT_Mu23_TrkIsoVVL_Ele8_CaloIdL_TrackIdL_IsoVL_DZ_v or \
                    ev.HLT_BIT_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_v or \
                    ev.HLT_BIT_HLT_Mu8_TrkIsoVVL_Ele23_CaloIdL_TrackIdL_IsoVL_DZ_v or \
                    ev.HLT_BIT_HLT_IsoMu24_v or \
                    ev.HLT_BIT_HLT_IsoTkMu24_v or \
                    ev.HLT_BIT_HLT_IsoMu22_eta2p1_v or \
                    ev.HLT_BIT_HLT_IsoTkMu22_eta2p1_v or \
                    ev.HLT_BIT_HLT_Ele27_WPTight_Gsf_v or \
                    ev.HLT_BIT_HLT_Ele25_eta2p1_WPTight_Gsf_v \
                    ] )))
MODULES.append( ('Trigger_3l', lambda : EvtTagger("Trigger_3l",[
                lambda ev : \
                    ev.HLT_TripleMu or \
                    ev.HLT_TripleEl or \
                    ev.HLT_DoubleMuEl or \
                    ev.HLT_DoubleElMu or \
                    ev.Trigger_2l \
                    ] )))


from CMGTools.TTHAnalysis.tools.bTagEventWeightsCSVFullShape import BTagEventWeightFriend
MODULES.append( ('eventBTagWeight', lambda : BTagEventWeightFriend(csvfile=os.environ["CMSSW_BASE"]+"/src/CMGTools/TTHAnalysis/data/btag/CSVv2_Moriond17_B_H.csv")))
