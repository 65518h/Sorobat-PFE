// Page 74788 "Ligne rapport Chantier APPRO"
// {//GL2024  ID dans Nav 2009 : "39004788"
//     PageType = ListPart;
//     SourceTable = "Ligne Rapport Chantier";
//     SourceTableView = where(Ressource = const(Appro));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field(Produit; Rec.Produit)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Num Bon Besoin"; Rec."Num Bon Besoin")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'N° Bon de Besoin';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Quantité Excutée"; Rec."Quantité Excutée")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Quantité Consommé';
//                 }
//                 field("Quantité Restante"; Rec."Quantité Restante")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Observation; Rec.Observation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Rec.Ressource := Rec.Ressource::Appro;
//     end;
// }

Page 74788 "Ligne rapport Chantier APPRO"
{
    PageType = ListPart;
    SourceTable = "Job Report Line";
    SourceTableView = where(Resource = const(Supply));
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Product; Rec.Product)
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Requirement Note No."; Rec."Requirement Note No.")
                {
                    ApplicationArea = Basic;
                    // Caption = 'N° Bon de Besoin';
                    Style = Strong;
                    StyleExpr = true;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecnvtShipmentHeader: Record "Invt. Shipment Header";
                        PagePostedInvtShipments: Page "Posted Invt. Shipments";
                        RecWipReportHeader: Record "WIP Report Header";
                        RecLInvtSetup: Record "Inventory Setup";
                        StartDate: Date;
                        EndDate: Date;
                        Txt0002: Label 'There are no validated stock shipments on the project %1 on the date %2..%3 .';
                    begin
                        RecLInvtSetup.get();
                        if RecWipReportHeader.Get(Rec."WIP Report No.") then begin
                            StartDate := calcdate(RecLInvtSetup."Inventory Consumption Delay", RecWipReportHeader."Starting date");
                            EndDate := RecWipReportHeader."Ending date";
                            RecnvtShipmentHeader.Reset();
                            RecnvtShipmentHeader.SetRange("DYSJob No.", Rec."Job No.");
                            RecnvtShipmentHeader.SetRange("Posting Date", StartDate, EndDate);
                            if not RecnvtShipmentHeader.FindSet() then begin
                                Message(Txt0002, Rec."Job No.", StartDate, EndDate);
                            end else
                                if Page.RunModal(Page::"Posted Invt. Shipments", RecnvtShipmentHeader) = Action::LookupOK then
                                    Rec.Validate("Requirement Note No.", RecnvtShipmentHeader."No.");
                            CurrPage.Update();
                        end;
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the N° Tâche Projet field.', Comment = '%';
                }

                field("Job Planning Line No."; Rec."Job Planning Line No.")
                { ApplicationArea = all; visible = false; }
                field("Quantity issued from store"; Rec."Quantity issued from store") { ApplicationArea = all; }
                field("Theoretical Unit Consumed Qty"; Rec."Theoretical Unit Consumed Qty") { ApplicationArea = all; visible = false; }
                field("Theoretical Consumed Quantity"; Rec."Theoretical Consumed Quantity") { ApplicationArea = all; Editable = false; }
                field("quantity variance"; Rec."quantity variance") { ApplicationArea = all; Editable = false; }
                field("Quantity Consumed"; Rec."Quantity Consumed")
                {
                    ApplicationArea = Basic;
                    //   Caption = 'Quantité Consommé';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = Basic;
                }
                field(Observation; Rec.Observation)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Resource := Rec.Resource::Supply;
    end;
}

