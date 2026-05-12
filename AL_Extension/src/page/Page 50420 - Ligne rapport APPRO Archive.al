Page 50190 "Ligne rapport APPRO archive"
{
    PageType = ListPart;
    SourceTable = "Job Report Line";
    SourceTableView = where(Resource = const(Supply));

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
                        Txt0002: Label 'There are no validated stock shipments on the project %1 on the date %2..%3 .';
                    begin
                        if RecWipReportHeader.Get(Rec."WIP Report No.") then begin
                            RecnvtShipmentHeader.Reset();
                            RecnvtShipmentHeader.SetRange("DYSJob No.", Rec."Job No.");
                            RecnvtShipmentHeader.SetRange("Posting Date", RecWipReportHeader."Starting date", RecWipReportHeader."Ending date");
                            if not RecnvtShipmentHeader.FindSet() then begin
                                Message(Txt0002, Rec."Job No.", RecWipReportHeader."Starting date", RecWipReportHeader."Ending date");
                            end else
                                if Page.RunModal(Page::"Posted Invt. Shipments", RecnvtShipmentHeader) = Action::LookupOK then
                                    Rec.Validate("Requirement Note No.", RecnvtShipmentHeader."No.");
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Job Planning Line No."; Rec."Job Planning Line No.") { ApplicationArea = all; }
                field("Quantity issued from store"; Rec."Quantity issued from store") { ApplicationArea = all; }
                field("Theoretical Unit Consumed Qty"; Rec."Theoretical Unit Consumed Qty") { ApplicationArea = all; }
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

