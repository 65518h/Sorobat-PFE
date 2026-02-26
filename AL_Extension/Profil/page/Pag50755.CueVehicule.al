page 50755 "CueVehicule"
{
    caption = 'Pointages Véhicules';
    PageType = CardPart;
    SourceTable = "Table cue";

    layout
    {
        area(Content)
        {
            cuegroup("Pointage Véhicule")
            {
                field("Nbr Pointage En cours"; REC."Nbr Pointage Vehicule en cours")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert';
                    ToolTip = 'Nbr Pointage Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueencours";



                }
                field("Nbr Pointage Validé"; REC."Nbr Pointage Vehicule Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé';
                    ToolTip = 'Nbr Pointage Validé', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCuevalide";
                }

                //DT
                field("Nbr Pointage Vehicule en cours PCENTRAL"; REC."Nbr Pointage Vehicule en cours PCENTRAL")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert PCENTRAL';
                    ToolTip = 'Nbr Pointage Ouvert PCENTRAL', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "PCENTRAL";



                }
                field("Nbr Pointage Vehicule Validé PCENTRAL"; REC."Nbr Pointage Vehicule Validé PCENTRAL")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé PCENTRAL';
                    ToolTip = 'Nbr Pointage Validé PCENTRAL', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "PCENTRAL";
                }

                //2
                field("Nbr Pointage Vehicule en cours CARRIERE_BOBO"; REC."Nbr Pointage Vehicule en cours CARRIERE_BOBO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert CARRIERE_BOBO';
                    ToolTip = 'Nbr Pointage Ouvert CARRIERE_BOBO', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCARRIERE_BOBO";



                }
                field("Nbr Pointage Vehicule Validé CARRIERE_BOBO"; REC."Nbr Pointage Vehicule Validé CARRIERE_BOBO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé CARRIERE_BOBO';
                    ToolTip = 'Nbr Pointage Validé CARRIERE_BOBO', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueCARRIERE_BOBO";
                }

                //2
                //3
                field("Nbr Pointage Vehicule en cours CHANTIER-BOBO"; REC."Nbr Pointage Vehicule en cours CHANTIER-BOBO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert CHANTIER-BOBO';
                    ToolTip = 'Nbr Pointage Ouvert CHANTIER-BOBO', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCHANTIER-BOBO";



                }
                field("Nbr Pointage Vehicule Validé CHANTIER-BOBO"; REC."Nbr Pointage Vehicule Validé CHANTIER-BOBO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé CHANTIER-BOBO';
                    ToolTip = 'Nbr Pointage Validé CHANTIER-BOBO', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueCHANTIER-BOBO";
                }

                //3

                //4
                field("Nbr Pointage Vehicule en cours CARRIERE_NIAOGHO"; REC."Nbr Pointage Vehicule en cours CARRIERE_NIAOGHO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert CARRIERE_NIAOGHO';
                    ToolTip = 'Nbr Pointage Ouvert CARRIERE_NIAOGHO', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCARRIERE_NIAOGHO";



                }
                field("Nbr Pointage Vehicule Validé CARRIERE_NIAOGHO"; REC."Nbr Pointage Vehicule Validé CARRIERE_NIAOGHO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé CARRIERE_NIAOGHO';
                    ToolTip = 'Nbr Pointage Validé CARRIERE_NIAOGHO', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueCARRIERE_NIAOGHO";
                }

                //4

                //5
                field("Nbr Pointage Vehicule en cours CARRIERE_NIGUI"; REC."Nbr Pointage Vehicule en cours CARRIERE_NIGUI")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert CARRIERE_NIGUI';
                    ToolTip = 'Nbr Pointage Ouvert CARRIERE_NIGUI', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCARRIERE_NIGUI";



                }
                field("Nbr Pointage Vehicule Validé CARRIERE_NIGUI"; REC."Nbr Pointage Vehicule Validé CARRIERE_NIGUI")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé CARRIERE_NIGUI';
                    ToolTip = 'Nbr Pointage Validé CARRIERE_NIGUI', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueCARRIERE_NIGUI";
                }


                //5

                //6
                field("Nbr Pointage Vehicule en cours RN-04 FADA"; REC."Nbr Pointage Vehicule en cours RN-04 FADA")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert RN-04 FADA';
                    ToolTip = 'Nbr Pointage Ouvert RN-04 FADA', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-04 FADA";



                }
                field("Nbr Pointage Vehicule Validé RN-04 FADA"; REC."Nbr Pointage Vehicule Validé RN-04 FADA")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé RN-04 FADA';
                    ToolTip = 'Nbr Pointage Validé RN-04 FADA', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueRN-04 FADA";
                }

                //6
                //7
                field("Nbr Pointage Vehicule en cours RN-04 LOT1 GOUNGHIN"; REC."Nbr Pointage Vehicule en cours RN-04 LOT1 GOUNGHIN")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert RN-04 LOT1 GOUNGHIN';
                    ToolTip = 'Nbr Pointage Ouvert RN-04 LOT1 GOUNGHIN', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-04 LOT1 GOUNGHIN";



                }
                field("Nbr Pointage Vehicule Validé RN-04 LOT1 GOUNGHIN"; REC."Nbr Pointage Vehicule Validé RN-04 LOT1 GOUNGHIN")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé RN-04 LOT1 GOUNGHIN';
                    ToolTip = 'Nbr Pointage Validé RN-04 LOT1 GOUNGHIN', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueRN-04 LOT1 GOUNGHIN";
                }
                //7


                //8
                field("Nbr Pointage Vehicule en cours RN17/TKD-ORG"; REC."Nbr Pointage Vehicule en cours RN17/TKD-ORG")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert RN17/TKD-ORG';
                    ToolTip = 'Nbr Pointage Ouvert RN17/TKD-ORG', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN17/TKD-ORG";



                }
                field("Nbr Pointage Vehicule Validé RN17/TKD-ORG"; REC."Nbr Pointage Vehicule Validé RN17/TKD-ORG")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé RN17/TKD-ORG';
                    ToolTip = 'Nbr Pointage Validé RN17/TKD-ORG', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueRN17/TKD-ORG";
                }



                //8


                //9
                field("Nbr Pointage Vehicule en cours LOT 4 RN22"; REC."Nbr Pointage Vehicule en cours LOT 4 RN22")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert LOT 4 RN22';
                    ToolTip = 'Nbr Pointage Ouvert LOT 4 RN22', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueLOT 4 RN22";



                }
                field("Nbr Pointage Vehicule Validé LOT 4 RN22"; REC."Nbr Pointage Vehicule Validé LOT 4 RN22")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé LOT 4 RN22';
                    ToolTip = 'Nbr Pointage Validé LOT 4 RN22', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueLOT 4 RN22";
                }


                //9
                //10
                field("Nbr Pointage Vehicule en cours RN-22/KON-DJI"; REC."Nbr Pointage Vehicule en cours RN-22/KON-DJI")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert RN-22/KON-DJI';
                    ToolTip = 'Nbr Pointage Ouvert RN-22/KON-DJI', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-22/KON-DJI";



                }
                field("Nbr Pointage Vehicule Validé RN-22/KON-DJI"; REC."Nbr Pointage Vehicule Validé RN-22/KON-DJI")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé RN-22/KON-DJI';
                    ToolTip = 'Nbr Pointage Validé RN-22/KON-DJI', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueRN-22/KON-DJI";
                }


                //10

                //11
                field("Nbr Pointage Vehicule en courRR-06/32"; REC."Nbr Pointage Vehicule en cours RR-06/32")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert RR-06/32';
                    ToolTip = 'Nbr Pointage Ouvert RR-06/32', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRR-06/32";



                }
                field("Nbr Pointage Vehicule Validé RR-06/32"; REC."Nbr Pointage Vehicule Validé RR-06/32")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé RR-06/32';
                    ToolTip = 'Nbr Pointage Validé RR-06/32', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueRR-06/32";
                }


                //11

                //12

                field("Nbr Pointage Vehicule en cours DAPELOGO-CENTRAL ENR"; REC."Nbr Pointage Vehicule en cours DAPELOGO-CENTRAL ENR")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert DAPELOGO-CENTRAL ENR';
                    ToolTip = 'Nbr Pointage Ouvert DAPELOGO-CENTRAL ENR', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueDAPELOGO-CENTRAL ENR";



                }
                field("Nbr Pointage Vehicule Validé DAPELOGO-CENTRAL ENR"; REC."Nbr Pointage Vehicule Validé DAPELOGO-CENTRAL ENR")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé DAPELOGO-CENTRAL ENR';
                    ToolTip = 'Nbr Pointage Validé DAPELOGO-CENTRAL ENR', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueDAPELOGO-CENTRAL ENR";
                }

                //13

                //14
                field("Nbr Pointage Vehicule en cours CHANTIER NAGRIN"; REC."Nbr Pointage Vehicule en cours CHANTIER NAGRIN")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert CHANTIER NAGRIN';
                    ToolTip = 'Nbr Pointage Ouvert CHANTIER NAGRIN', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCHANTIER NAGRIN";



                }
                field("Nbr Pointage Vehicule Validé CHANTIER NAGRIN"; REC."Nbr Pointage Vehicule Validé CHANTIER NAGRIN")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé CHANTIER NAGRIN';
                    ToolTip = 'Nbr Pointage Validé CHANTIER NAGRIN', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueCHANTIER NAGRIN";
                }

                //14


                //15
                field("Nbr Pointage Vehicule en cours SGSOCIAL"; REC."Nbr Pointage Vehicule en cours SGSOCIAL")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert SGSOCIAL';
                    ToolTip = 'Nbr Pointage Ouvert SGSOCIAL', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueSGSOCIAL";



                }
                field("Nbr Pointage Vehicule Validé SGSOCIAL"; REC."Nbr Pointage Vehicule Validé SGSOCIAL")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé SGSOCIAL';
                    ToolTip = 'Nbr Pointage Validé SGSOCIAL', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueSGSOCIAL";
                }

                //15

                //16
                field("Nbr Pointage Vehicule en cours TRANSPORT"; REC."Nbr Pointage Vehicule en cours TRANSPORT")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Ouvert TRANSPORT';
                    ToolTip = 'Nbr Pointage Ouvert TRANSPORT', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueTRANSPORT";



                }
                field("Nbr Pointage Vehicule Validé TRANSPORT"; REC."Nbr Pointage Vehicule Validé TRANSPORT")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Nbr Pointage Validé TRANSPORT';
                    ToolTip = 'Nbr Pointage Validé TRANSPORT', Comment = '%';
                    DrillDownPageId = "Liste Entete Pointage Veh En.";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueTRANSPORT";
                }

                //16
                //DT















            }
            // cuegroup("Historique Transfert Vehicule")
            // {
            //     // CueGroupLayout = Wide;
            //     // ShowCaption = false;
            //     field("Nbr Transfert En cours"; REC."Nbr Transfert Engin en cours")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         caption = 'Nbr Transfert Ouvert';
            //         ToolTip = 'Nbr Transfert Ouvert', Comment = '%';
            //         DrillDownPageId = "Liste Transfert Engins";
            //         Image = None;
            //         StyleExpr = true;
            //         style = Attention;
            //     }
            //     field("Nbr Transfert Lancé"; REC."Nbr Transfert Engin lancé")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         caption = 'Nbr Transfert Lancé';
            //         ToolTip = 'Nbr Transfert Lancé', Comment = '%';
            //         DrillDownPageId = "Liste Transfert Engins";
            //         Image = None;
            //         StyleExpr = true;
            //         style = Subordinate;
            //     }
            // }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        rec.RESET();
        IF NOT rec.GET THEN BEGIN
            rec.INIT();
            rec.INSERT();
        END;
        "PCENTRAL" := false;
        "ShowCueCARRIERE_BOBO" := false;
        "ShowCueCHANTIER-BOBO" := false;
        "ShowCueCARRIERE_NIAOGHO" := false;
        "ShowCueCARRIERE_NIGUI" := false;
        "ShowCueRN-04 FADA" := false;
        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
        "ShowCueRN17/TKD-ORG" := false;
        "ShowCueLOT 4 RN22" := false;
        "ShowCueRN-22/KON-DJI" := false;
        "ShowCueRR-06/32" := false;
        "ShowCueDAPELOGO-CENTRAL ENR" := false;
        "ShowCueCHANTIER NAGRIN" := false;
        "ShowCueSGSOCIAL" := false;
        "ShowCueTRANSPORT" := false;
        "ShowCuecaisseCentral" := false;
        "ShowCueencours" := true;

        "ShowCuevalide" := true;




        if UserSetup.Get(UserId()) then begin
            case UserSetup.Affaire of
                'PCENTRAL':
                    begin
                        "PCENTRAL" := true;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'CARRIERE_BOBO':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := true;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'CHANTIER-BOBO':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := true;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;


                'CARRIERE_NIAOGHO':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := true;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'CARRIERE_NIGUI':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := true;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'RN-04 FADA':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := true;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'RN-04 LOT1 GOUNGHIN':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := true;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'RN17/TKD-ORG':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := true;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;
                'LOT 4 RN22':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := true;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'RN-22/KON-DJI':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := true;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;
                'RR-06/32':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := true;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'DAPELOGO-CENTRAL ENR':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := true;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'CHANTIER NAGRIN':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := true;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;
                'SGSOCIAL':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := true;
                        "ShowCueTRANSPORT" := false;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                'TRANSPORT':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := true;
                        "ShowCueencours" := false;

                        "ShowCuevalide" := false;



                    end;

                '':
                    begin
                        "PCENTRAL" := false;
                        "ShowCueCARRIERE_BOBO" := false;
                        "ShowCueCHANTIER-BOBO" := false;
                        "ShowCueCARRIERE_NIAOGHO" := false;
                        "ShowCueCARRIERE_NIGUI" := false;
                        "ShowCueRN-04 FADA" := false;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := false;
                        "ShowCueRN17/TKD-ORG" := false;
                        "ShowCueLOT 4 RN22" := false;
                        "ShowCueRN-22/KON-DJI" := false;
                        "ShowCueRR-06/32" := false;
                        "ShowCueDAPELOGO-CENTRAL ENR" := false;
                        "ShowCueCHANTIER NAGRIN" := false;
                        "ShowCueSGSOCIAL" := false;
                        "ShowCueTRANSPORT" := false;



                        "ShowCueencours" := true;

                        "ShowCuevalide" := true;



                    end;









            end;
        end;





    end;

    var
        myInt: Integer;


        [InDataSet]
        "PCENTRAL": Boolean;
        [InDataSet]
        "ShowCueCARRIERE_BOBO": Boolean;
        [InDataSet]
        "ShowCueCHANTIER-BOBO": Boolean;
        [InDataSet]
        "ShowCueCARRIERE_NIAOGHO": Boolean;
        [InDataSet]
        "ShowCueCARRIERE_NIGUI": Boolean;
        [InDataSet]
        "ShowCueRN-04 FADA": Boolean;
        [InDataSet]
        "ShowCueRN-04 LOT1 GOUNGHIN": Boolean;
        [InDataSet]
        "ShowCueRN17/TKD-ORG": Boolean;
        [InDataSet]
        "ShowCueLOT 4 RN22": Boolean;
        [InDataSet]
        "ShowCueRN-22/KON-DJI": Boolean;
        [InDataSet]
        "ShowCueRR-06/32": Boolean;
        [InDataSet]
        "ShowCueDAPELOGO-CENTRAL ENR": Boolean;
        [InDataSet]
        "ShowCueCHANTIER NAGRIN": Boolean;
        [InDataSet]
        "ShowCueSGSOCIAL": Boolean;
        [InDataSet]
        "ShowCueTRANSPORT": Boolean;
        [InDataSet]
        "ShowCuecaisseCentral": Boolean;
        [InDataSet]
        "ShowCueencours": Boolean;
        [InDataSet]
        "ShowCuevalide": Boolean;

}
