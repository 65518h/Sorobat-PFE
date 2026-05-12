page 50746 "CueCaisse"
{
    caption = 'Caisses';
    PageType = CardPart;
    SourceTable = "Table cue";

    layout
    {
        area(Content)
        {
            cuegroup(Solde_Caisse_Centrale)
            {
                // CueGroupLayout = Wide;
                // ShowCaption = false;
                field("ADMINISTRATION"; Rec."Solde Caisse Central")
                {
                    ApplicationArea = Basic, Suite;
                    caption = '';
                    ToolTip = '', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCuecaisseCentral";

                }
            }
            cuegroup(Solde_Caisse_Divers_Chantiers)
            {
                field("PCENTRAL"; Rec."PCENTRAL")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'PCENTRAL';
                    ToolTip = 'PCENTRAL', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "PCENTRAL";
                }
                // field("AEROPORT_DONSIN"; Rec."AEROPORT_DONSIN")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'AEROPORT_DONSIN';
                //     ToolTip = 'AEROPORT_DONSIN', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Favorable;
                //     Visible = false;
                // }
                field("CARRIERE_BOBO"; Rec."CARRIERE_BOBO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'CARRIERE_BOBO';
                    ToolTip = 'CARRIERE_BOBO', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Favorable;
                    Visible = "ShowCueCARRIERE_BOBO";
                }

                field("CHANTIER-BOBO"; Rec."CHANTIER-BOBO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'CHANTIER-BOBO';
                    ToolTip = 'CHANTIER-BOBO', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Favorable;
                    Visible = "ShowCueCHANTIER-BOBO";
                }
                field("CARRIERE_NIAOGHO"; Rec."CARRIERE_NIAOGHO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'CARRIERE_NIAOGHO';
                    ToolTip = 'CARRIERE_NIAOGHO', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Favorable;
                    Visible = "ShowCueCARRIERE_NIAOGHO";
                }
                field("CARRIERE_NIGUI"; Rec."CARRIERE_NIGUI")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'CARRIERE_NIGUI';
                    ToolTip = 'CARRIERE_NIGUI', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Favorable;
                    Visible = "ShowCueCARRIERE_NIGUI";
                }
                // field("CARRIERE_NINGUI"; Rec."CARRIERE_NINGUI")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'CARRIERE_NINGUI';
                //     ToolTip = 'CARRIERE_NINGUI', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Favorable;
                //     Visible = false;
                // }
                // field("CARRIEREBOUDRI"; Rec."CARRIEREBOUDRI")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                //     caption = 'CARRIEREBOUDRI';
                //     ToolTip = 'CARRIEREBOUDRI', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Favorable;
                // }
                // field("CYANKASOU"; Rec."CYANKASOU")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                //     caption = 'CYANKASOU';
                //     ToolTip = 'CYANKASOU', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Favorable;
                // }
                // field("DRAIN-TANGHIN"; Rec."DRAIN-TANGHIN")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'DRAIN-TANGHIN';
                //     Visible = false;
                //     ToolTip = 'DRAIN-TANGHIN', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Favorable;
                // }
                // field("LOMBELA"; Rec."LOMBELA")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'LOMBELA';
                //     ToolTip = 'LOMBELA', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Favorable;
                //     Visible = false;
                // }
                // field("LOT13-0001"; Rec."LOT13-0001")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'LOT13-0001';
                //     Visible = false;
                //     ToolTip = 'LOT13-0001', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }
                // field("LOT1-KOP"; Rec."LOT1-KOP")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'LOT1-KOP';
                //     ToolTip = 'LOT1-KOP', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     Visible = false;
                //     style = Attention;
                // }
                // field("LOT2-TKD"; Rec."LOT2-TKD")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                //     caption = 'LOT2-TKD';
                //     ToolTip = 'LOT2-TKD', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }
                // field("LOT3-BITOU"; Rec."LOT3-BITOU")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                //     caption = 'LOT3-BITOU';
                //     ToolTip = 'LOT3-BITOU', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }
                // field("LOTNOUNA"; Rec."LOTNOUNA")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'LOTNOUNA';
                //     Visible = false;
                //     ToolTip = 'LOTNOUNA', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }
                // field("NORD OUAGA"; Rec."NORD OUAGA")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Visible = false;
                //     caption = 'NORD OUAGA';
                //     ToolTip = 'NORD OUAGA', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }
                // field("OUAGA TANGHIN"; Rec."OUAGA TANGHIN")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'OUAGA TANGHIN';
                //     Visible = false;
                //     ToolTip = 'OUAGA TANGHIN', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }

                // field("RN-04"; Rec."RN-04")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'RN-04';
                //     Visible = false;
                //     ToolTip = 'RN-04', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }
                field("RN-04 FADA"; Rec."RN-04 FADA")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'RN-04 FADA';
                    ToolTip = 'RN-04 FADA', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-04 FADA";
                }
                field("RN-04 LOT1 GOUNGHIN"; Rec."RN-04 LOT1 GOUNGHIN")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'RN-04 LOT1 GOUNGHIN';
                    ToolTip = 'RN-04 LOT1 GOUNGHIN', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-04 LOT1 GOUNGHIN";
                }
                // field("RN10"; Rec."RN10")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'RN10';
                //     ToolTip = 'RN10', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     Visible = false;
                //     style = Attention;
                // }
                // field("RN-14"; Rec."RN-14")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'RN-14';
                //     ToolTip = 'RN-14', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                //     Visible = false;
                // }
                // field("RN-17"; Rec."RN-17")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'RN-17';
                //     ToolTip = 'RN-17', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                //     Visible = false;
                // }
                field("RN17/TKD-ORG"; Rec."RN17/TKD-ORG")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'RN17/TKD-ORG';
                    ToolTip = 'RN17/TKD-ORG', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    Visible = "ShowCueRN17/TKD-ORG";
                    style = Attention;
                }

                field("LOT 4 RN22"; Rec."LOT 4 RN22")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'LOT 4 RN22';
                    ToolTip = 'LOT 4 RN22', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueLOT 4 RN22";
                }
                // field("RN19"; Rec."RN19")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'RN19';
                //     ToolTip = 'RN19', Comment = '%';
                //     Visible = false;
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }
                // field("RN-22"; Rec."RN-22")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'RN-22';
                //     ToolTip = 'RN-22', Comment = '%';
                //     Visible = false;
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }
                field("RN-22/KON-DJI"; Rec."RN-22/KON-DJI")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'RN-22/KON-DJI';
                    ToolTip = 'RN-22/KON-DJI', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-22/KON-DJI";
                }
                field("RR-06/32"; Rec."RR-06/32")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'RR-06/32';
                    ToolTip = 'RR-06/32', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRR-06/32";
                }
                // field("RR-29"; Rec."RR-29")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'RR-29';
                //     Visible = false;
                //     ToolTip = 'RR-29', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     style = Attention;
                // }

                field("DAPELOGO-CENTRAL ENR"; Rec."DAPELOGO-CENTRAL ENR")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'DAPELOGO-CENTRAL ENR';

                    ToolTip = 'DAPELOGO-CENTRAL ENR', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueDAPELOGO-CENTRAL ENR";
                }


                field("CHANTIER NAGRIN"; Rec."CHANTIER NAGRIN")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'CHANTIER NAGRIN';

                    ToolTip = 'CHANTIER NAGRIN', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCHANTIER NAGRIN";
                }
                field("SGSOCIAL"; Rec."SGSOCIAL")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'SGSOCIAL';
                    ToolTip = 'SGSOCIAL', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueSGSOCIAL";
                }
                // field("STOCK"; Rec."STOCK")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'STOCK';
                //     ToolTip = 'STOCK', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None; 
                //     StyleExpr = true;
                //     style = Attention;
                //     Visible = false;
                // }
                field("TRANSPORT"; Rec."TRANSPORT")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'TRANSPORT';
                    ToolTip = 'TRANSPORT', Comment = '%';
                    DrillDownPageId = "Ligne Caisse Comptabilisé";
                    // Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueTRANSPORT";
                }
                // field("VENTE"; Rec."VENTE")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'VENTE';
                //     ToolTip = 'VENTE', Comment = '%';
                //     DrillDownPageId = "Ligne Caisse Comptabilisé";
                //     // Image = None;
                //     StyleExpr = true;
                //     Visible = false;
                //     style = Attention;
                // }
            }
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

                    end;

                '':
                    begin
                        "PCENTRAL" := true;
                        "ShowCueCARRIERE_BOBO" := true;
                        "ShowCueCHANTIER-BOBO" := true;
                        "ShowCueCARRIERE_NIAOGHO" := true;
                        "ShowCueCARRIERE_NIGUI" := true;
                        "ShowCueRN-04 FADA" := true;
                        "ShowCueRN-04 LOT1 GOUNGHIN" := true;
                        "ShowCueRN17/TKD-ORG" := true;
                        "ShowCueLOT 4 RN22" := true;
                        "ShowCueRN-22/KON-DJI" := true;
                        "ShowCueRR-06/32" := true;
                        "ShowCueDAPELOGO-CENTRAL ENR" := true;
                        "ShowCueCHANTIER NAGRIN" := true;
                        "ShowCueSGSOCIAL" := true;
                        "ShowCueTRANSPORT" := true;
                        "ShowCuecaisseCentral" := true;

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
}
