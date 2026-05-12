//GL3900 
// Page 72143 "Fiche Déclencheur"
// {//GL2024  ID dans Nav 2009 : "39002143"
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
//                 group(Equipement)
//                 {
//                     label(Matricule)
//                     {
//                         ApplicationArea = Basic;
//                         CaptionClass = Text19045580;
//                     }
//                 }
//                 group("Déclencheur")
//                 {
//                     field(Type; Rec.Type)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Type';

//                         trigger OnValidate()
//                         begin
//                             //GL2024

//                             // Initialisation des données
//                             rec.Durée := 0;
//                             rec.Symptôme := '';
//                             rec.Mesure := '';
//                             // Fin Initialisation
//                             CASE rec.Type OF
//                                 rec.Type::" ":
//                                     BEGIN
//                                         DuréeEDITABLE := FALSE;
//                                         TxtPériodeEDITABLE := FALSE;
//                                         MesureEditable := FALSE;
//                                         SymptômeEDITABLE := FALSE;
//                                         DateFixeEditable := FALSE;
//                                         PrévueEDITABLE := FALSE;
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
//                                         SymptômeEDITABLE := FALSE;
//                                         DateFixeEditable := TRUE;
//                                         PrévueEDITABLE := TRUE;
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
//                                         SymptômeEDITABLE := FALSE;
//                                         DateFixeEditable := FALSE;
//                                         PrévueEDITABLE := FALSE;
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
//                                         SymptômeEDITABLE := TRUE;
//                                         DateFixeEditable := FALSE;
//                                         PrévueEDITABLE := FALSE;
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
//                 }
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Déclencheur';
//                     Lookup = true;
//                 }
//                 group("Caractéristiques")
//                 {
//                     field("Durée"; Rec.Durée)
//                     {
//                         ApplicationArea = Basic;

//                         Caption = 'Période';
//                         Editable = "DuréeEDITABLE";
//                         Enabled = true;
//                     }
//                     field("TxtPériode"; Rec.Période)
//                     {
//                         ApplicationArea = Basic;
//                         Editable = "TxtPériodeEDITABLE";
//                         Enabled = true;
//                         OptionCaption = 'Jours,Semaine,Mois,Année';
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
//                     field(Actif; Rec.Actif)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Actif';
//                     }
//                 }
//                 field(Control1000000003; Rec.Equipement)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Equipement';
//                     Lookup = true;

//                     trigger OnValidate()
//                     begin
//                         recOTP.Get(Rec.OTP);
//                         recOTP.cd_box := Rec.Equipement;
//                         recOTP.Modify
//                     end;
//                 }
//                 field(Control1000000004; Rec.Matricule)
//                 {
//                     ApplicationArea = Basic;
//                     Lookup = true;

//                     trigger OnValidate()
//                     begin
//                         recOTP.Get(Rec.OTP);
//                         recOTP.cd_matricule := Rec.Matricule;
//                         recOTP.Modify
//                     end;
//                 }
//             }
//             group("Action")
//             {
//                 Caption = 'Action';
//                 field(OTP; Rec.OTP)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
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
//                     field(DateFixe; Rec."Date Fixe")
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Théorique';
//                         Editable = DateFixeEditable;

//                         trigger OnValidate()
//                         begin
//                             if Rec."Date Fixe" then begin
//                                 Rec.Durée := 1;
//                                 Rec.Période := Rec.Période::Mois;
//                                 Rec.Prévue := 0D;
//                             end
//                             else
//                                 Rec.ProchainLancementd := 0D;
//                         end;
//                     }
//                     field("Prévue"; Rec.Prévue)
//                     {
//                         Editable = "PrévueEDITABLE";
//                         ApplicationArea = Basic;
//                     }
//                     field(ProchainLancementd; Rec.ProchainLancementd)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Prochain Lancement';
//                         Editable = ProchainLancementdEditable;
//                     }
//                 }
//                 field(Etat; Rec.Etat)
//                 {
//                     ApplicationArea = Basic;
//                     OptionCaption = 'Simulé,Lancé,Terminé';
//                 }
//                 group(Valeurs)
//                 {
//                     field("Théorique"; Rec.Théorique)
//                     {
//                         Editable = "ThéoriqueEDITABLE";
//                         ApplicationArea = Basic;
//                     }
//                     field(Effective; Rec.Effective)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Effective';
//                         Editable = EffectiveEditable;
//                     }
//                     field("UnitéE"; Rec.UnitéE)
//                     {
//                         Editable = "UnitéEEDITABLE";
//                         ApplicationArea = Basic;
//                     }
//                     field(ProchainLancementv; Rec.ProchainLancementv)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Prochain Lancement';
//                         Editable = ProchainLancementvEditable;
//                     }
//                 }
//                 field("UnitéT"; Rec.UnitéT)
//                 {
//                     Editable = "UnitéTEDITABLE";
//                     ApplicationArea = Basic;
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
//         area(processing)
//         {
//             action("Plan Prev")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Plan Prev';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     Codeunit.Run(39002017);
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin


//         CASE rec.Type OF
//             rec.Type::" ":
//                 BEGIN
//                     DuréeEDITABLE := FALSE;
//                     TxtPériodeEDITABLE := FALSE;
//                     MesureEditable := FALSE;
//                     SymptômeEDITABLE := FALSE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
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
//                     SymptômeEDITABLE := FALSE;
//                     DateFixeEditable := TRUE;
//                     PrévueEDITABLE := TRUE;
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
//                     SymptômeEDITABLE := FALSE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
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
//                     SymptômeEDITABLE := TRUE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
//                     ProchainLancementdEditable := FALSE;
//                     ThéoriqueEDITABLE := FALSE;
//                     UnitéEEDITABLE := FALSE;
//                     UnitéTEDITABLE := FALSE;
//                     ProchainLancementvEditable := FALSE;
//                     EffectiveEditable := FALSE;
//                 END
//         END;
//         Pr233vueOnFormat;
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
//         Text19045580: label 'Matricule';




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

//         CASE rec.Type OF
//             rec.Type::" ":
//                 BEGIN

//                     DuréeEDITABLE := FALSE;
//                     TxtPériodeEDITABLE := FALSE;
//                     MesureEditable := FALSE;
//                     SymptômeEDITABLE := FALSE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
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
//                     SymptômeEDITABLE := FALSE;
//                     DateFixeEditable := TRUE;
//                     PrévueEDITABLE := TRUE;
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
//                     SymptômeEDITABLE := FALSE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
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
//                     SymptômeEDITABLE := TRUE;
//                     DateFixeEditable := FALSE;
//                     PrévueEDITABLE := FALSE;
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

//     local procedure ProchainLancementdOnFormat()
//     begin
//         if (Rec."Date Fixe") then
//             ProchainLancementdEditable := true
//         else
//             ProchainLancementdEditable := false;
//     end;
// }

