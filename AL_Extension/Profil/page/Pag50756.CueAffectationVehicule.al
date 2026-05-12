page 50756 "CueAffectationVehicule"
{
    caption = 'Affectation Véhicules';
    PageType = CardPart;
    SourceTable = "Table cue";

    layout
    {
        area(Content)
        {
            cuegroup("Affectation Véhicule")
            {
                field("Nbr Vehicule PARC CENTRAL"; REC."Nbr Vehicule PARC CENTRAL")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules Parc Central';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;

                    style = Subordinate;
                    Visible = "PCENTRAL";



                }

                field("Nbr Vehicule CARRIERE_BOBO"; Rec."Nbr Vehicule CARRIERE_BOBO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules CARRIERE BOBO';

                    DrillDownPageId = "List Véhicules";
                    Visible = "ShowCueCARRIERE_BOBO";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;


                }


                field("Nbr Vehicule CHANTIER-BOBO"; Rec."Nbr Vehicule CHANTIER-BOBO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules CHANTIER-BOBO';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueCHANTIER-BOBO";


                }

                field("Nbr VehiculeCARRIERE_NIAOGHO"; Rec."Nbr VehiculeCARRIERE_NIAOGHO")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules CARRIERE NIAOGHO';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueCARRIERE_NIAOGHO";


                }

                field("Nbr VehiculeCARRIERE_NIGUI"; Rec."Nbr VehiculeCARRIERE_NIGUI")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules CARRIERE NIGUI';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCARRIERE_NIGUI";


                }




                field("Nbr Vehicule Affecté Sbikha"; REC."Nbr Vehicule RN-04 FADA")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules RN-04 FADA';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueRN-04 FADA";


                }

                field("Nbr VehiculeRN-04 LOT1 GOUNGHIN"; Rec."Nbr VehiculeRN-04 LOT1 GOUNGHIN")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules RN-04 LOT1 GOUNGHIN';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueRN-04 LOT1 GOUNGHIN";


                }


                field("Nbr VehiculeRN17/TKD-ORG"; Rec."Nbr VehiculeRN17/TKD-ORG")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules RN17/TKD-ORG';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueRN17/TKD-ORG";


                }

                field("Nbr VehiculeLOT 4 RN22"; rec."Nbr VehiculeLOT 4 RN22")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules LOT 4 RN22';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueLOT 4 RN22";


                }


                field("Nbr Vehicule Affecté PENLOT2"; REC."Nbr Vehicule RN-22/KON-DJI")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules RN-22/KON-DJI';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Unfavorable;
                    Visible = "ShowCueRN-22/KON-DJI";


                }
                field("Nbr VehiculeRR-06/32"; REC."Nbr VehiculeRR-06/32")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules RR-06/32';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueRR-06/32";


                }





                field("Nbr VehiculeDAPELOGO-CENTRAL ENR"; rec."Nbr VehiculeDAPELOGO-CENTRAL ENR")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules DAPELOGO-CENTRAL ENR';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueDAPELOGO-CENTRAL ENR";


                }


                field("Nbr VehiculeCHANTIER NAGRIN"; rec."Nbr VehiculeCHANTIER NAGRIN")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicule CHANTIER NAGRIN"';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Attention;
                    Visible = "ShowCueCHANTIER NAGRIN";


                }


                field("Nbr VehiculeSGSOCIAL"; Rec."Nbr VehiculeSGSOCIAL")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules SGSOCIAL';

                    DrillDownPageId = "List Véhicules";
                    Image = None;
                    StyleExpr = true;
                    style = Subordinate;
                    Visible = "ShowCueSGSOCIAL";


                }


                field("Nbr VehiculeTRANSPORT"; Rec."Nbr VehiculeTRANSPORT")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Vehicules TRANSPORT';

                    DrillDownPageId = "List Véhicules";
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
}
