Page 50085 "Mouvements Stock Vehicules"
{
    Caption = 'Mouvements Stock Vehicules';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    //GL2024   SourceTableView = sorting("N° Véhicule", "Item No.", "Posting Date");
    SourceTableView = sorting("N° Véhicule", "Item No.", "Posting Date") WHERE("N° Véhicule" = FILTER(<> ''));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Document Line No."; rec."Document Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                // field(Emplacement; rec.Emplacement)
                // {
                //     ApplicationArea = all;
                // }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Expiration Date"; rec."Expiration Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("N° Véhicule"; rec."N° Véhicule")
                {
                    ApplicationArea = all;
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Invoiced Quantity"; rec."Invoiced Quantity")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Remaining Quantity"; rec."Remaining Quantity")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Shipped Qty. Not Returned"; rec."Shipped Qty. Not Returned")
                {
                    ApplicationArea = all;
                    Visible = false;
                }





                //GL2024




                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Control52; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sales Amount (Expected)"; rec."Sales Amount (Expected)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }


                field("Sales Amount (Actual)"; rec."Sales Amount (Actual)")
                {
                    ApplicationArea = all;
                }


                field("Cost Amount (Expected)"; rec."Cost Amount (Expected)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cost Amount (Actual)"; rec."Cost Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Non-Invtbl.)"; rec."Cost Amount (Non-Invtbl.)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Expected) (ACY)"; rec."Cost Amount (Expected) (ACY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cost Amount (Actual) (ACY)"; rec."Cost Amount (Actual) (ACY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Completely Invoiced"; rec."Completely Invoiced")
                {
                    ApplicationArea = all;
                    Visible = false;
                }


                //GL2024






                field(Open; rec.Open)
                {
                    ApplicationArea = all;
                }
                field("Drop Shipment"; rec."Drop Shipment")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Applied Entry to Adjust"; rec."Applied Entry to Adjust")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                /* GL2024 field("Prod. Order No."; rec."Prod. Order No.")
                  {
                      ApplicationArea = all;
                      Visible = false;
                  }
                  field("Prod. Order Line No."; rec."Prod. Order Line No.")
                  {
                      ApplicationArea = all;
                      Visible = false;
                  }*/
                field("Prod. Order Comp. Line No."; rec."Prod. Order Comp. Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Control26; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        Navigate: Page Navigate;


    procedure GetCaption(): Text[250]
    var
        GLSetup: Record "General Ledger Setup";
        ObjTransl: Record "Object Translation";
        Item: Record Item;
        ProdOrder: Record "Production Order";
        Cust: Record Customer;
        Vend: Record Vendor;
        Dimension: Record Dimension;
        DimValue: Record "Dimension Value";
        SourceTableName: Text[100];
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description := '';

        case true of
            rec.GetFilter("Item No.") <> '':
                begin
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."object type"::Table, 27);
                    SourceFilter := rec.GetFilter("Item No.");
                    if MaxStrLen(Item."No.") >= StrLen(SourceFilter) then
                        if Item.Get(SourceFilter) then
                            Description := Item.Description;
                end;
            /* GL2024 rec.GetFilter("Prod. Order No.") <> '':
                  begin
                      SourceTableName := ObjTransl.TranslateObject(ObjTransl."object type"::Table, 5405);
                      SourceFilter := rec.GetFilter("Prod. Order No.");
                      if MaxStrLen(ProdOrder."No.") >= StrLen(SourceFilter) then
                          if ProdOrder.Get(ProdOrder.Status::Released, SourceFilter) or
                             ProdOrder.Get(ProdOrder.Status::Finished, SourceFilter)
                          then begin
                              SourceTableName := StrSubstNo('%1 %2', ProdOrder.Status, SourceTableName);
                              Description := ProdOrder.Description;
                          end;
                  end;*/
            rec.GetFilter("Source No.") <> '':
                begin
                    case rec."Source Type" of
                        rec."source type"::Customer:
                            begin
                                SourceTableName :=
                                  ObjTransl.TranslateObject(ObjTransl."object type"::Table, 18);
                                SourceFilter := rec.GetFilter("Source No.");
                                if MaxStrLen(Cust."No.") >= StrLen(SourceFilter) then
                                    if Cust.Get(SourceFilter) then
                                        Description := Cust.Name;
                            end;
                        rec."source type"::Vendor:
                            begin
                                SourceTableName :=
                                  ObjTransl.TranslateObject(ObjTransl."object type"::Table, 23);
                                SourceFilter := rec.GetFilter("Source No.");
                                if MaxStrLen(Vend."No.") >= StrLen(SourceFilter) then
                                    if Vend.Get(SourceFilter) then
                                        Description := Vend.Name;
                            end;
                    end;
                end;
            rec.GetFilter("Global Dimension 1 Code") <> '':
                begin
                    GLSetup.Get;
                    Dimension.Code := GLSetup."Global Dimension 1 Code";
                    SourceFilter := rec.GetFilter("Global Dimension 1 Code");
                    SourceTableName := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLSetup."Global Dimension 1 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
            rec.GetFilter("Global Dimension 2 Code") <> '':
                begin
                    GLSetup.Get;
                    Dimension.Code := GLSetup."Global Dimension 2 Code";
                    SourceFilter := rec.GetFilter("Global Dimension 2 Code");
                    SourceTableName := Dimension.GetMLName(GlobalLanguage);
                    if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter) then
                        if DimValue.Get(GLSetup."Global Dimension 2 Code", SourceFilter) then
                            Description := DimValue.Name;
                end;
            rec.GetFilter("Document Type") <> '':
                begin
                    SourceTableName := rec.GetFilter("Document Type");
                    SourceFilter := rec.GetFilter("Document No.");
                    Description := rec.GetFilter("Document Line No.");
                end;
        end;
        exit(StrSubstNo('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;
}

