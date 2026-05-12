PageExtension 50048 "Purchase Quote Subform_PagEXT" extends "Purchase Quote Subform"
{
    layout
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            begin

                //MULTIPLE
                CurrPage.SAVERECORD;
                //MULTIPLE//
            end;
        }

        modify("Line Discount %")
        {
            Visible = false;
        }

        modify("No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            VAR
                lMultiple: Boolean;
                lLookup: Codeunit Lookup;
            begin

                //MULTIPLE
                //#5084 Currpage.SAVERECORD;
                //#5084 COMMIT;
                //#7750
                CASE (rec.Type) OF
                    rec.Type::Item:
                        BEGIN
                            wRecordref.OPEN(DATABASE::Item);
                            IF rec.wLookUpNo(Rec, wRecordref, lMultiple, xRec) THEN
                                IF NOT lMultiple THEN
                                    InsertExtendedText(FALSE)
                                ELSE
                                    IF rec."Line No." = 0 THEN
                                        wMult := TRUE;
                            //#4842
                            wRecordref.CLOSE;
                            //#4842//
                        END;
                    rec.Type::"G/L Account":
                        BEGIN
                            wRecordref.OPEN(DATABASE::"G/L Account");
                            IF rec.wLookUpNo(Rec, wRecordref, lMultiple, xRec) THEN
                                IF NOT lMultiple THEN
                                    InsertExtendedText(FALSE)
                                ELSE
                                    IF rec."Line No." = 0 THEN
                                        wMult := TRUE;
                            //#4842
                            wRecordref.CLOSE;
                            //#4842//
                        END;
                    ELSE BEGIN
                        lLookup.PurchLineNo(Rec);
                        //#8504
                        InsertExtendedText(FALSE);
                        //#8504//
                    END;
                END;
                //#7750//
                //MULTIPLE//
            end;
        }

        addafter("No.")
        {
            field("Work Center No."; Rec."Work Center No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                IF rec.Type = rec.Type::Item THEN ERROR(Text001);
            end;

            trigger OnAssistEdit()
            begin

                //ACHATS
                Currpage.SAVERECORD;
                //#9175
                COMMIT;
                IF rec.fMemoPad THEN
                    Currpage.UPDATE;
                //IF wEditMemoPad THEN
                //  Currpage.UPDATE;
                //#9175//
                //ACHATS//
            end;
        }

        modify("Description 2")
        {
            trigger OnAssistEdit()
            begin


                //ACHATS
                Currpage.SAVERECORD;
                IF wEditMemoPad THEN
                    Currpage.UPDATE;
                //ACHATS//
            end;
        }




        addafter("Location Code")
        {
            field("Value 1"; rec."Value 1")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 2"; rec."Value 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 3"; rec."Value 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 4"; rec."Value 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 5"; rec."Value 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 6"; rec."Value 6")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 7"; rec."Value 7")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 8"; rec."Value 8")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 9"; rec."Value 9")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 10"; rec."Value 10")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Line Amount")
        {
            field("Discount 1 %"; rec."Discount 1 %")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Discount 2 %"; rec."Discount 2 %")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Discount 3 %"; rec."Discount 3 %")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }


        addafter("Allow Invoice Disc.")
        {
            field("Job No.2"; rec."dysJob No.")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                //Visible = false;
            }
            field("DYSJob Task No."; Rec."DYSJob Task No.")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                //Visible = false;
                Caption = 'Numéro Tâche du travail';
            }
            /*GL2026  field("Line Discount %1"; Rec."Line Discount %")
              {

              }

              field("Line Discount Amount1"; Rec."Line Discount Amount")
              {

              }*/
            field("Job Task No.2"; rec."Job Task No.")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Visible = false;
            }
        }
        modify("Job No.")
        {
            Visible = false;
        }
        modify("Job Task No.")
        {
            Visible = false;
        }






        addafter("Appl.-to Item Entry")
        {
            field("Requested Receipt Date"; rec."Requested Receipt Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("ShortcutDimCode8")
        {
            field(wInternalOrderExist; wInternalOrderExist)
            {
                ApplicationArea = all;
                Caption = 'Internal Order';
                Visible = false;
            }
            field(wTransferOrderExist; wTransferOrderExist)
            {
                ApplicationArea = all;
                Caption = 'Transfer Order';
                Visible = true;
            }
        }
    }





    trigger OnAfterGetRecord()
    begin

        //+OFF+OFFRE
        wInitialPurchLine.INIT;
        IF wIsRelatedOffer THEN
            IF NOT wInitialPurchLine.GET(rec."Attached to Doc. Type", rec."Attached to Doc. No.", rec."Line No.") THEN
                wInitialPurchLine.INIT;
        //+OFF+OFFRE//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.INIT;
        //+OFF+OFFRE
        IF wIsRelatedOffer THEN BEGIN
            MESSAGE(Text8004090);
            EXIT;
        END;
        //+OFF+OFFRE//
        //ACHATS
        rec.wInitLocationCode;
        //ACHATS//
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //MULTIPLE
        IF wMult THEN BEGIN
            wMult := FALSE;
            EXIT(FALSE);
        END;
        //MULTIPLE//

    end;


    trigger OnModifyRecord(): Boolean
    VAR
        lPurchLine: Record "Purchase Line";
    begin

        //+OFF+OFFRE
        IF rec."Attached to Doc. No." <> '' THEN BEGIN
            lPurchLine.SETRANGE("Document Type", lPurchLine."Document Type"::Order);
            lPurchLine.SETRANGE("Line No.", rec."Line No.");
            lPurchLine.SETRANGE("Price Offer No.", rec."Attached to Doc. No.");
            IF lPurchLine.FIND('-') THEN
                ERROR(Text8004091, lPurchLine."Document No.")
            ELSE
                IF lPurchLine.GET(rec."Attached to Doc. Type", rec."Attached to Doc. No.", rec."Line No.") THEN
                    IF lPurchLine."Ordered Line" THEN
                        ERROR(Text8004092);
        END;
        //+OFF+OFFRE//
    end;



    procedure wEditMemoPad(): Boolean
    var
        lCaption: Text[250];
        lMemoPad: Codeunit "MemoPad Management";
        lNewText: Boolean;
        lRec: Record "Purchase Line";
        lRec2: Record "Purchase Line";
        lRecordRef: RecordRef;
    begin
        //ACHATS
        lNewText := (rec."Line No." = 0);
        if rec."Attached to Line No." = 0 then begin
            rec.TestField("No.");
            lRec := Rec;
        end else
            lRec.Get(rec."Document Type", rec."Document No.", rec."Attached to Line No.");
        lCaption := lRec.Description;

        if not lNewText then begin
            lRec.Init; //Keep Primary key
            lRec.SetRange("Document Type", rec."Document Type");
            lRec.SetRange("Document No.", rec."Document No.");
            lRec.SetRange(Type, lRec.Type::" ");
            lRec.SetRange("No.", '');
            lRec.SetRange("Attached to Line No.", lRec."Line No.");
            lRec.Description := lCaption;
            lRec."Attached to Line No." := lRec."Line No.";
        end else begin
            rec.Validate(Description, ' ');
            CurrPage.Update(true);
            lRec.Init; //Keep Primary key
            lRec.SetRange("Document Type", rec."Document Type");
            lRec.SetRange("Document No.", rec."Document No.");
            lRec.SetRange("Line No.", rec."Line No.");
            lRec."Line No." := rec."Line No.";
        end;

        lRecordRef.GetTable(lRec);
        //#5464
        //EXIT(lMemoPad.Edit2(lRecordRef,lCaption,FALSE,FIELDNO(Description),FIELDNO("Description 2"),FIELDNO(Separator)));
        exit(lMemoPad.Edit(lRecordRef, lCaption));
        //#5464//
    end;

    procedure wShowDescription()
    var
        lDescription: Record "Description Line";
    begin
        //OUVRAGE
        rec.TestField("Line No.");
        lDescription.ShowDescription(39, rec."Document Type", rec."Document No.", rec."Line No.");
        //OUVRAGE//
    end;

    procedure wShowRelatedOfferLines()
    var
        lPurchLine: Record "Purchase Line";
    //DYS page addon non migrer
    // lShowOfferLine: Page 8004093;
    begin
        //OFFRE_DE_PRIX
        lPurchLine.Reset;
        lPurchLine.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
        lPurchLine.SetRange("Attached to Doc. Type", rec."Document Type");
        lPurchLine.SetRange("Attached to Doc. No.", rec."Document No.");
        lPurchLine.SetRange("No.", rec."No.");
        lPurchLine.SetRange("Line No.", rec."Line No.");
        if lPurchLine.Find('-') then begin
            //DYS
            // lShowOfferLine.SetTableview(lPurchLine);
            // lShowOfferLine.Run;
        end;
        //OFFRE_DE_PRIX//
    end;

    procedure wSetRelatedOffer(Status: Boolean)
    begin
        //+OFF+OFFRE
        wIsRelatedOffer := Status;
        //+OFF+OFFRE//
    end;

    procedure wShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        //+OFF+OFFRE
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RunModal;
        //+OFF+OFFRE//
    end;

    procedure wOpenSalesForm()
    var
        lSalesHeader: Record "Sales Header";
        lSalesNavibatQuote: Page "Sales Quote";
        lSalesNavibatOrder: Page "Sales Order";
    begin
        //SUBCONTRACTOR
        if rec."Sales Order Line No." <> 0 then
            lSalesHeader.SetRange("No.", rec."Sales Order No.")
        else
            if rec."Special Order Sales Line No." <> 0 then
                lSalesHeader.SetRange("No.", rec."Special Order Sales No.");
        case rec."Sales Document Type" of
            rec."sales document type"::Quote:
                begin
                    lSalesNavibatQuote.SetTableview(lSalesHeader);
                    lSalesNavibatQuote.Editable := false;
                    lSalesNavibatQuote.Run;
                end;
            rec."sales document type"::Order, rec."sales document type"::" ":
                begin
                    lSalesNavibatOrder.SetTableview(lSalesHeader);
                    lSalesNavibatOrder.Editable := false;
                    lSalesNavibatOrder.Run;
                end;
        end;
        //SUBCONTRACTOR//
    end;








    var
        PurchHeader: Record "Purchase Header";
        wIsRelatedOffer: Boolean;
        wInitialPurchLine: Record "Purchase Line";
        wRecordref: RecordRef;
        wMult: Boolean;
        wInternalOrderExist: Boolean;
        wTransferOrderExist: Boolean;
        wItem: Record Item;
        Text8004090: label 'You can''t insert line when inherited attachments exist.';
        Text8004091: label 'You cannot change this line because it is associated with purchase order no. %1.';
        Text8004092: label 'You cannot change this line because it has been invoiced.';
        Text001: label 'You cannot modify the designation';

}

