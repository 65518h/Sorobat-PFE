//GL3900 
// Page 72163 "Déclencheur"
// {//GL2024  ID dans Nav 2009 : "39002163"
//     Caption = 'Fiche Déclencheur';
//     PageType = Card;
//     SourceTable = "Déclencheur";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Déclenchement")
//             {
//                 Caption = 'Déclenchement';
//                 label("Déclencheur1")
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19014113;
//                 }
//                 group(Equipement1)
//                 {
//                     field(Control1000000003; Rec.Equipement)
//                     {
//                         ApplicationArea = Basic;
//                         Lookup = true;

//                         trigger OnValidate()
//                         begin
//                             recOTP.Get(Rec.OTP);
//                             recOTP.cd_box := Rec.Equipement;
//                             recOTP.Modify
//                         end;
//                     }
//                     field(Control1000000004; Rec.Matricule)
//                     {
//                         ApplicationArea = Basic;
//                         Lookup = true;

//                         trigger OnValidate()
//                         begin
//                             recOTP.Get(Rec.OTP);
//                             recOTP.cd_matricule := Rec.Matricule;
//                             recOTP.Modify
//                         end;
//                     }
//                 }
//                 label(Equipement)
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19071643;
//                 }
//                 label(Matricule)
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19045580;
//                 }
//                 group("Déclencheur")
//                 {
//                     field(Control1000000010; Rec.Type)
//                     {
//                         ApplicationArea = Basic;

//                         trigger OnValidate()
//                         begin

//                             CASE rec.Type OF
//                                 rec.Type::" ":
//                                     BEGIN
//                                         DuréeEDITABLE := FALSE;
//                                         TxtPériodeEDITABLE := FALSE;
//                                         MesureEditable := FALSE;
//                                         CSymptômeEDITABLE := FALSE;
//                                         DateFixeEditable := FALSE;
//                                         PrévueEDITABLE := FALSE;
//                                         RéaliséEDITABLE := FALSE;
//                                         ProchainLancementdEditable := FALSE;
//                                         ThéoriqueEDITABLE := FALSE;
//                                         UnitéEEDITABLE := FALSE;
//                                         UnitéTEDITABLE := FALSE;
//                                         ProchainLancementvEditable := FALSE;
//                                         EffectiveEditable := FALSE;
//                                     END;

//                                 rec.Type::"Sur Déclenchement Calendaire":
//                                     BEGIN
//                                         DuréeEDITABLE := TRUE;
//                                         TxtPériodeEDITABLE := TRUE;
//                                         MesureEditable := FALSE;
//                                         CSymptômeEDITABLE := FALSE;
//                                         DateFixeEditable := TRUE;
//                                         PrévueEDITABLE := TRUE;
//                                         RéaliséEDITABLE := TRUE;
//                                         ProchainLancementdEditable := TRUE;
//                                         ThéoriqueEDITABLE := FALSE;
//                                         UnitéEEDITABLE := FALSE;
//                                         UnitéTEDITABLE := FALSE;
//                                         ProchainLancementvEditable := FALSE;
//                                         EffectiveEditable := FALSE;
//                                     END;

//                                 rec.Type::"Sur Prise de Mesure":
//                                     BEGIN
//                                         DuréeEDITABLE := FALSE;
//                                         TxtPériodeEDITABLE := FALSE;
//                                         MesureEditable := TRUE;
//                                         CSymptômeEDITABLE := FALSE;
//                                         DateFixeEditable := FALSE;
//                                         PrévueEDITABLE := FALSE;
//                                         RéaliséEDITABLE := FALSE;
//                                         ProchainLancementdEditable := FALSE;
//                                         ThéoriqueEDITABLE := TRUE;
//                                         UnitéEEDITABLE := TRUE;
//                                         UnitéTEDITABLE := TRUE;
//                                         ProchainLancementvEditable := TRUE;
//                                         EffectiveEditable := TRUE;
//                                     END;

//                                 rec.Type::"Sur Symptôme":
//                                     BEGIN
//                                         DuréeEDITABLE := FALSE;
//                                         TxtPériodeEDITABLE := FALSE;
//                                         MesureEditable := FALSE;
//                                         CSymptômeEDITABLE := TRUE;
//                                         DateFixeEditable := FALSE;
//                                         PrévueEDITABLE := FALSE;
//                                         RéaliséEDITABLE := FALSE;
//                                         ProchainLancementdEditable := FALSE;
//                                         ThéoriqueEDITABLE := FALSE;
//                                         UnitéEEDITABLE := FALSE;
//                                         UnitéTEDITABLE := FALSE;
//                                         ProchainLancementvEditable := FALSE;
//                                         EffectiveEditable := FALSE;
//                                     END
//                             END;

//                             if Rec.Type = 1 then
//                                 DateFixeEditable := true;
//                             TypeOnAfterValidate;

//                         end;
//                     }
//                     field(Responsable; Rec.Responsable)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Responsable';
//                     }
//                     field(Mesure; Rec.Mesure)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Type de Mesure';
//                         Editable = MesureEditable;
//                         Enabled = true;
//                     }
//                     field("Symptôme"; Rec.Symptôme)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Type de Symptôme';
//                         Editable = "SymptômeEDITABLE";
//                         Enabled = true;
//                         Lookup = true;
//                     }
//                 }
//                 label(Type)
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19052420;
//                 }
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Lookup = true;
//                 }
//                 group("Caractéristiques")
//                 {
//                     label(Control1000000013)
//                     {
//                         ApplicationArea = Basic;
//                         CaptionClass = Text19064754;
//                     }
//                     label("Horizon (Jours)")
//                     {
//                         ApplicationArea = Basic;
//                         CaptionClass = Text19031782;
//                     }
//                     field(Control1000000005; Rec.Actif)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field("Priorité"; Rec.Priorité)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                     field(Horizon; Rec.Horizon)
//                     {
//                         ApplicationArea = Basic;
//                     }
//                 }
//                 label(Actif)
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19064621;
//                 }
//                 field("Durée"; Rec.Durée)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Période';
//                     Editable = DuréeEDITABLE;
//                     Enabled = true;
//                 }
//                 field("TxtPériode"; Rec.Période)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "TxtPériodeEDITABLE";
//                     Enabled = true;
//                     OptionCaption = 'Jours,Semaine,Mois,Année';
//                 }
//             }
//             group("Action")
//             {
//                 Caption = 'Action';
//                 field(OTP; Rec.OTP)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Libellé"; Rec.Libellé)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin

//                         recOTP.Get(Rec.OTP);
//                         recOTP.Titre := Rec.Libellé;
//                         recOTP.Modify
//                     end;
//                 }
//                 group(Dates)
//                 {
//                     Caption = 'Dates';
//                     label("Déclenchement à date fixe")
//                     {
//                         ApplicationArea = Basic;
//                         CaptionClass = Text19074894;
//                     }
//                     field(DateFixe; Rec."Date Fixe")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'DateFixe';
//                         Editable = DateFixeEditable;
//                     }
//                     field("Prévue"; Rec.Prévue)
//                     {
//                         Editable = "PrévueEDITABLE";
//                         ApplicationArea = Basic;
//                     }
//                 }
//                 label("Réalisé1")
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19054892;
//                 }
//                 label("Prochain Lancement")
//                 {
//                     ApplicationArea = Basic;
//                     CaptionClass = Text19050294;
//                 }
//                 field(Etat; Rec.Etat)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Réalisé"; Rec.Réalisé)
//                 {
//                     Editable = "RéaliséEDITABLE";
//                     ApplicationArea = Basic;
//                 }
//                 field(ProchainLancementd; Rec.ProchainLancementd)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = ProchainLancementdEditable;
//                 }
//                 group(Valeurs)
//                 {
//                     field("Théorique"; Rec.Théorique)
//                     {
//                         ApplicationArea = Basic;
//                         Editable = "ThéoriqueEDITABLE";
//                         Caption = 'Théorique';
//                     }
//                     field("UnitéT"; Rec.UnitéT)
//                     {
//                         Editable = "UnitéTEDITABLE";
//                         ApplicationArea = Basic;
//                     }
//                     field("UnitéE"; Rec.UnitéE)
//                     {
//                         Editable = "UnitéEEDITABLE";
//                         ApplicationArea = Basic;
//                     }
//                 }
//                 field(Effective; Rec.Effective)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Effective';
//                     Editable = EffectiveEditable;
//                 }
//                 field(ProchainLancementv; Rec.ProchainLancementv)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Prochain Lancement';
//                     Editable = ProchainLancementvEditable;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Fonctions)
//             {
//                 Caption = 'Fonctions';
//                 action("Fiche OTP")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Fiche OTP';

//                     trigger OnAction()
//                     begin
//                         t.SetRange("code OTP", Rec.OTP);
//                         //t.INSERT(TRUE);
//                         if t.FindFirst then
//                             Page.Run(39002087, t);
//                         //t.INSERT(TRUE);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         //GL2024
//         CASE rec.Type OF
//             rec.Type::" ":
//                 BEGIN
//                     DuréeEDITABLE := FALSE;
//                     TxtPériodeEDITABLE := FALSE;
//                     MesureEditable := FALSE;
//                     CSymptômeEDITABLE := FALSE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
//                     RéaliséEDITABLE := FALSE;
//                     ProchainLancementdEditable := FALSE;
//                     ThéoriqueEDITABLE := FALSE;
//                     UnitéEEDITABLE := FALSE;
//                     UnitéTEDITABLE := FALSE;
//                     ProchainLancementvEditable := FALSE;
//                     EffectiveEditable := FALSE;
//                 END;

//             rec.Type::"Sur Déclenchement Calendaire":
//                 BEGIN
//                     DuréeEDITABLE := TRUE;
//                     TxtPériodeEDITABLE := TRUE;
//                     MesureEditable := FALSE;
//                     CSymptômeEDITABLE := FALSE;
//                     DateFixeEditable := TRUE;
//                     PrévueEDITABLE := TRUE;
//                     RéaliséEDITABLE := TRUE;
//                     ProchainLancementdEditable := TRUE;
//                     ThéoriqueEDITABLE := FALSE;
//                     UnitéEEDITABLE := FALSE;
//                     UnitéTEDITABLE := FALSE;
//                     ProchainLancementvEditable := FALSE;
//                     EffectiveEditable := FALSE;
//                 END;

//             rec.Type::"Sur Prise de Mesure":
//                 BEGIN
//                     DuréeEDITABLE := FALSE;
//                     TxtPériodeEDITABLE := FALSE;
//                     MesureEditable := TRUE;
//                     CSymptômeEDITABLE := FALSE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
//                     RéaliséEDITABLE := FALSE;
//                     ProchainLancementdEditable := FALSE;
//                     ThéoriqueEDITABLE := TRUE;
//                     UnitéEEDITABLE := TRUE;
//                     UnitéTEDITABLE := TRUE;
//                     ProchainLancementvEditable := TRUE;
//                     EffectiveEditable := TRUE;
//                 END;

//             rec.Type::"Sur Symptôme":
//                 BEGIN
//                     DuréeEDITABLE := FALSE;
//                     TxtPériodeEDITABLE := FALSE;
//                     MesureEditable := FALSE;
//                     CSymptômeEDITABLE := TRUE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
//                     RéaliséEDITABLE := FALSE;
//                     ProchainLancementdEditable := FALSE;
//                     ThéoriqueEDITABLE := FALSE;
//                     UnitéEEDITABLE := FALSE;
//                     UnitéTEDITABLE := FALSE;
//                     ProchainLancementvEditable := FALSE;
//                     EffectiveEditable := FALSE;
//                 END
//         END;
//         Pr233vueOnFormat;
//         R233alis233OnFormat;
//         ProchainLancementdOnFormat;

//     end;

//     trigger OnInit()
//     begin
//         EffectiveEditable := true;
//         ProchainLancementvEditable := true;
//         ProchainLancementdEditable := true;
//         MesureEditable := true;
//         DateFixeEditable := true;
//     end;

//     trigger OnOpenPage()
//     begin
//         OnActivateForm;
//     end;

//     var
//         PlanningGetParam: Integer;
//         SetUpPlanningControls: Integer;
//         t: Record OTP;
//         recOTP: Record OTP;
//         [InDataSet]
//         DateFixeEditable: Boolean;
//         [InDataSet]
//         MesureEditable: Boolean;
//         [InDataSet]
//         ProchainLancementdEditable: Boolean;
//         [InDataSet]
//         ProchainLancementvEditable: Boolean;
//         [InDataSet]
//         EffectiveEditable: Boolean;
//         Text19014113: label 'Déclencheur';
//         Text19071643: label 'Equipement';
//         Text19045580: label 'Matricule';
//         Text19074894: label 'Déclenchement à date fixe';
//         Text19052420: label 'Type';
//         Text19054892: label 'Réalisé';
//         Text19050294: label 'Prochain Lancement';
//         Text19064754: label 'Prioritaire';
//         Text19031782: label 'Horizon (Jours)';
//         Text19064621: label 'Actif';
//         [InDataSet]
//         DuréeEDITABLE: Boolean;
//         [InDataSet]
//         TxtPériodeEDITABLE: Boolean;
//         [InDataSet]
//         SymptômeEDITABLE: Boolean;
//         [InDataSet]
//         PrévueEDITABLE: Boolean;
//         [InDataSet]
//         ThéoriqueEDITABLE: Boolean;
//         [InDataSet]
//         UnitéEEDITABLE: Boolean;
//         [InDataSet]
//         UnitéTEDITABLE: Boolean;
//         [InDataSet]
//         RéaliséEDITABLE: Boolean;
//         [InDataSet]
//         CSymptômeEDITABLE: Boolean;



//     procedure EnablePlanningControls()
//     begin
//     end;

//     local procedure TypeOnAfterValidate()
//     begin

//         if Rec.Type = 1 then
//             DateFixeEditable := true;
//     end;

//     local procedure OnActivateForm()
//     begin
//         //GL2024
//         CASE rec.Type OF
//             rec.Type::" ":
//                 BEGIN
//                     DuréeEDITABLE := FALSE;
//                     TxtPériodeEDITABLE := FALSE;
//                     MesureEditable := FALSE;
//                     CSymptômeEDITABLE := FALSE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
//                     RéaliséEDITABLE := FALSE;
//                     ProchainLancementdEditable := FALSE;
//                     ThéoriqueEDITABLE := FALSE;
//                     UnitéEEDITABLE := FALSE;
//                     UnitéTEDITABLE := FALSE;
//                     ProchainLancementvEditable := FALSE;
//                     EffectiveEditable := FALSE;
//                 END;

//             rec.Type::"Sur Déclenchement Calendaire":
//                 BEGIN
//                     DuréeEDITABLE := TRUE;
//                     TxtPériodeEDITABLE := TRUE;
//                     MesureEditable := FALSE;
//                     CSymptômeEDITABLE := FALSE;
//                     DateFixeEditable := TRUE;
//                     PrévueEDITABLE := TRUE;
//                     RéaliséEDITABLE := TRUE;
//                     ProchainLancementdEditable := TRUE;
//                     ThéoriqueEDITABLE := FALSE;
//                     UnitéEEDITABLE := FALSE;
//                     UnitéTEDITABLE := FALSE;
//                     ProchainLancementvEditable := FALSE;
//                     EffectiveEditable := FALSE;
//                 END;

//             rec.Type::"Sur Prise de Mesure":
//                 BEGIN
//                     DuréeEDITABLE := FALSE;
//                     TxtPériodeEDITABLE := FALSE;
//                     MesureEditable := TRUE;
//                     CSymptômeEDITABLE := FALSE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
//                     RéaliséEDITABLE := FALSE;
//                     ProchainLancementdEditable := FALSE;
//                     ThéoriqueEDITABLE := TRUE;
//                     UnitéEEDITABLE := TRUE;
//                     UnitéTEDITABLE := TRUE;
//                     ProchainLancementvEditable := TRUE;
//                     EffectiveEditable := TRUE;
//                 END;

//             rec.Type::"Sur Symptôme":
//                 BEGIN
//                     DuréeEDITABLE := FALSE;
//                     TxtPériodeEDITABLE := FALSE;
//                     MesureEditable := FALSE;
//                     CSymptômeEDITABLE := TRUE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
//                     RéaliséEDITABLE := FALSE;
//                     ProchainLancementdEditable := FALSE;
//                     ThéoriqueEDITABLE := FALSE;
//                     UnitéEEDITABLE := FALSE;
//                     UnitéTEDITABLE := FALSE;
//                     ProchainLancementvEditable := FALSE;
//                     EffectiveEditable := FALSE;
//                 END
//         END;


//     end;

//     local procedure Pr233vueOnFormat()
//     begin


//         IF (rec."Date Fixe") OR (rec.Type <> 1) THEN
//             PrévueEDITABLE := FALSE
//         ELSE
//             PrévueEDITABLE := TRUE;

//     end;

//     local procedure R233alis233OnFormat()
//     begin

//         IF (rec."Date Fixe") OR (rec.Type <> 1) THEN
//             RéaliséEDITABLE := FALSE
//         ELSE
//             RéaliséEDITABLE := TRUE;

//     end;

//     local procedure ProchainLancementdOnFormat()
//     begin
//         if (Rec."Date Fixe") then
//             ProchainLancementdEditable := true
//         else
//             ProchainLancementdEditable := false;
//     end;
// }

