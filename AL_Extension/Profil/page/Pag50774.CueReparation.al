page 50774 "Cue Réparation"
{
    caption = 'Réparation';
    PageType = CardPart;
    SourceTable = "Table cue";

    layout
    {
        area(Content)
        {

            cuegroup("Réparation")
            {
                field("Réparation Ouvert"; REC."Réparation Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation Ouvert';
                    ToolTip = 'Réparation Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueencours";
                }
                field("Réparation Validé"; REC."Réparation Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation Validé';
                    ToolTip = 'Réparation Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCuevalide";
                }
                //1

                field("Réparation PCENTRAL Ouvert"; REC."Réparation PCENTRAL Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation PCENTRAL Ouvert';
                    ToolTip = 'Réparation PCENTRAL Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "PCENTRAL";
                }
                field("Réparation PCENTRAL Validé"; REC."Réparation PCENTRAL Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation PCENTRAL Validé';
                    ToolTip = 'Réparation PCENTRAL Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "PCENTRAL";
                }
                //2

                field("Réparation CARRIERE_BOBO Ouvert"; REC."Réparation CARRIERE_BOBO Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CARRIERE_BOBO Ouvert';
                    ToolTip = 'Réparation CARRIERE_BOBO Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueCARRIERE_BOBO";
                }
                field("Réparation CARRIERE_BOBO Validé"; REC."Réparation CARRIERE_BOBO Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CARRIERE_BOBO Validé';
                    ToolTip = 'Réparation CARRIERE_BOBO Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCARRIERE_BOBO";
                }
                //3

                field("Réparation CHANTIER-BOBO Ouvert"; REC."Réparation CHANTIER-BOBO Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CHANTIER-BOBO Ouvert';
                    ToolTip = 'Réparation CHANTIER-BOBO Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueCHANTIER-BOBO";
                }
                field("Réparation CHANTIER-BOBO Validé"; REC."Réparation CHANTIER-BOBO Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CHANTIER-BOBO Validé';
                    ToolTip = 'Réparation CHANTIER-BOBO Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCHANTIER-BOBO";
                }

                //4

                field("Réparation CARRIERE_NIAOGHO Ouvert"; REC."Réparation CARRIERE_NIAOGHO Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CARRIERE_NIAOGHO Ouvert';
                    ToolTip = 'Réparation CARRIERE_NIAOGHO Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueCARRIERE_NIAOGHO";
                }
                field("Réparation CARRIERE_NIAOGHO Validé"; REC."Réparation CARRIERE_NIAOGHO Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CARRIERE_NIAOGHO Validé';
                    ToolTip = 'Réparation CARRIERE_NIAOGHO Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCARRIERE_NIAOGHO";
                }

                //5
                field("Réparation CARRIERE_NIGUI Ouvert"; REC."Réparation CARRIERE_NIGUI Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CARRIERE_NIGUI Ouvert';
                    ToolTip = 'Réparation CARRIERE_NIGUI Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueCARRIERE_NIGUI";
                }
                field("Réparation CARRIERE_NIGUI Validé"; REC."Réparation CARRIERE_NIGUI Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CARRIERE_NIGUI Validé';
                    ToolTip = 'Réparation CARRIERE_NIGUI Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCARRIERE_NIGUI";
                }
                //6
                field("Réparation RN-04 FADA Ouvert"; REC."Réparation RN-04 FADA Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RN-04 FADA Ouvert';
                    ToolTip = 'Réparation RN-04 FADA Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueRN-04 FADA";
                }
                field("Réparation RN-04 FADA Validé"; REC."Réparation RN-04 FADA Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RN-04 FADA Validé';
                    ToolTip = 'Réparation RN-04 FADA Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-04 FADA";
                }
                //7
                field("Réparation RN-04 LOT1 GOUNGHIN Ouvert"; REC."Réparation RN-04 LOT1 GOUNGHIN Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RN-04 LOT1 GOUNGHIN Ouvert';
                    ToolTip = 'Réparation RN-04 LOT1 GOUNGHIN Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueRN-04 LOT1 GOUNGHIN";
                }
                field("Réparation RN-04 LOT1 GOUNGHIN Validé"; REC."Réparation RN-04 LOT1 GOUNGHIN Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RN-04 LOT1 GOUNGHIN Validé';
                    ToolTip = 'Réparation RN-04 LOT1 GOUNGHIN Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-04 LOT1 GOUNGHIN";
                }
                //8
                field("Réparation RN17/TKD-ORG Ouvert"; REC."Réparation RN17/TKD-ORG Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RN17/TKD-ORG Ouvert';
                    ToolTip = 'Réparation RN17/TKD-ORG Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueRN17/TKD-ORG";
                }
                field("Réparation RN17/TKD-ORG Validé"; REC."Réparation RN17/TKD-ORG Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RN17/TKD-ORG Validé';
                    ToolTip = 'Réparation RN17/TKD-ORG Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN17/TKD-ORG";
                }
                //9
                field("Réparation LOT 4 RN22 Ouvert"; REC."Réparation LOT 4 RN22 Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation LOT 4 RN22 Ouvert';
                    ToolTip = 'Réparation LOT 4 RN22 Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueLOT 4 RN22";
                }
                field("Réparation LOT 4 RN22 Validé"; REC."Réparation LOT 4 RN22 Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation LOT 4 RN22 Validé';
                    ToolTip = 'Réparation LOT 4 RN22 Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueLOT 4 RN22";
                }

                //10
                field("Réparation RN-22/KON-DJI Ouvert"; REC."Réparation RN-22/KON-DJI Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RN-22/KON-DJI Ouvert';
                    ToolTip = 'Réparation RN-22/KON-DJI Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueRN-22/KON-DJI";
                }
                field("Réparation RN-22/KON-DJI Validé"; REC."Réparation RN-22/KON-DJI Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RN-22/KON-DJI Validé';
                    ToolTip = 'Réparation RN-22/KON-DJI Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN-22/KON-DJI";
                }

                //11
                field("Réparation RR-06/32 Ouvert"; REC."Réparation RR-06/32 Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RR-06/32 Ouvert';
                    ToolTip = 'Réparation RR-06/32 Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueRR-06/32";
                }
                field("Réparation RR-06/32 Validé"; REC."Réparation RR-06/32 Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation RR-06/32 Validé';
                    ToolTip = 'Réparation RR-06/32 Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRR-06/32";
                }

                //12
                field("Réparation DAPELOGO-CENTRAL ENR Ouvert"; REC."Réparation DAPELOGO-CENTRAL ENR Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation DAPELOGO-CENTRAL ENR Ouvert';
                    ToolTip = 'Réparation DAPELOGO-CENTRAL ENR Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueDAPELOGO-CENTRAL ENR";
                }
                field("Réparation DAPELOGO-CENTRAL ENR Validé"; REC."Réparation DAPELOGO-CENTRAL ENR Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation DAPELOGO-CENTRAL ENR Validé';
                    ToolTip = 'Réparation DAPELOGO-CENTRAL ENR Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueDAPELOGO-CENTRAL ENR";
                }


                //13
                field("Réparation CHANTIER NAGRIN Ouvert"; REC."Réparation CHANTIER NAGRIN Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CHANTIER NAGRIN Ouvert';
                    ToolTip = 'Réparation CHANTIER NAGRIN Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueCHANTIER NAGRIN";
                }
                field("Réparation CHANTIER NAGRIN Validé"; REC."Réparation CHANTIER NAGRIN Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation CHANTIER NAGRIN Validé';
                    ToolTip = 'Réparation CHANTIER NAGRIN Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCHANTIER NAGRIN";
                }

                //14
                field("Réparation SGSOCIAL Ouvert"; REC."Réparation SGSOCIAL Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation SGSOCIAL Ouvert';
                    ToolTip = 'Réparation SGSOCIAL Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueSGSOCIAL";
                }
                field("Réparation SGSOCIAL Validé"; REC."Réparation SGSOCIAL Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation SGSOCIAL Validé';
                    ToolTip = 'Réparation SGSOCIAL Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueSGSOCIAL";
                }

                //15
                field("Réparation TRANSPORT Ouvert"; REC."Réparation TRANSPORT Ouvert")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation TRANSPORT Ouvert';
                    ToolTip = 'Réparation TRANSPORT Ouvert', Comment = '%';
                    DrillDownPageId = "Liste Réparation";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueTRANSPORT";
                }
                field("Réparation TRANSPORT Validé"; REC."Réparation TRANSPORT Validé")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Réparation TRANSPORT Validé';
                    ToolTip = 'Réparation TRANSPORT Validé', Comment = '%';
                    DrillDownPageId = "Liste Réparation Validé";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueTRANSPORT";
                }
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
