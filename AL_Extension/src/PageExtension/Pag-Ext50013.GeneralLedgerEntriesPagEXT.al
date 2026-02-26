PageExtension 50013 "General Ledger Entries_PagEXT" extends "General Ledger Entries"
{
    layout
    {
        modify("Source Code")
        {
            Visible = true;
        }
        addafter("Posting Date")
        {
            field("Transaction No."; rec."Transaction No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("<Amount2>"; rec.Amount)
            {
                ApplicationArea = all;
            }
            field("Subscription Entry No."; rec."Subscription Entry No.")
            {
                ApplicationArea = all;
                Visible = true;
            }
        }



        addafter("G/L Account Name")
        {
            field("Source Type2"; rec."Source Type")
            {
                ApplicationArea = all;
            }
            field("Source No.2"; rec."Source No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("Debit Amount1"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount1"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }
            field("Subscription Starting Date"; rec."Subscription Starting Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Subscription End Date"; rec."Subscription End Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("VAT Amount")
        {
            field("BaseTVA"; BaseTVA)
            {
                ApplicationArea = All;
                Caption = 'Base TVA';
                ToolTip = 'Specifies the value of the Base TVA field.', Comment = '%';
                Style = Favorable;
            }


            field(salarie; rec.salarie)
            {
                ApplicationArea = all;
            }
        }
        addafter("Entry No.")
        {
            field(Letter; rec.Letter)
            {
                ApplicationArea = all;
            }
            field(NOM; rec.NOM)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Nom fournisseur"; Rec."Nom fournisseur")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("N° identif. intracomm."; rec."N° identif. intracomm.")
            {
                ApplicationArea = all;
                Editable = false;
            }

            /* field("Date Echeance"; rec."Date Echeance")
             {
                 ApplicationArea = all;
                 Editable = false;
             }
             field("Folio N°"; rec."Folio N°")
             {
                 ApplicationArea = all;
             }*/
        }
    }
    actions
    {

        addafter("Value Entries")
        {
            action("Modifier champs extra-comp")
            {
                ApplicationArea = all;
                Caption = 'Modify Extra-Accountants Fields';

                trigger OnAction()
                var
                    //DYS REPORT addon non migrer
                    // lModifyExtraFields: Report 8001905;
                    lGLEntry: Record "G/L Entry";
                begin

                    //+ABO+
                    lGLEntry.Copy(Rec);
                    CurrPage.SetSelectionFilter(lGLEntry);
                    //lModifyExtraFields.GetSelectedLines(lGLEntry);
                    //lModifyExtraFields.RunModal;
                    //+ABO+//
                end;
            }
            separator(Action1000000013)
            {
            }
            action("Ecritures abonnement")
            {
                Caption = 'Subscription Entries';
                ApplicationArea = all;

                trigger OnAction()
                var
                    lGLEntry: Record "G/L Entry";
                begin

                    rec.TestField("Subscription Entry No.");
                    lGLEntry.SetRange("Subscription Entry No.", rec."Subscription Entry No.");
                    lGLEntry.SetRange("G/L Account No.", rec."G/L Account No.");
                    Page.Run(Page::"General Ledger Entries", lGLEntry);
                end;
            }



            action("Batch vendor")
            {
                Caption = 'Batch vendor';
                ApplicationArea = all;
                Visible = false;

                trigger OnAction()
                var
                    lGLEntry: Record "G/L Entry";
                    vendor: Record Vendor;
                begin


                    if lGLEntry.FindSet() then
                        repeat
                            if vendor.get(lGLEntry."Source No.") then begin
                                lGLEntry."Nom fournisseur" := vendor.Name;
                                lGLEntry.Address := vendor.Address;
                                lGLEntry."Address 2" := vendor."Address 2";
                                lGLEntry."N° identif. intracomm." := vendor."VAT Registration No.";
                                lGLEntry.Modify()
                            end;

                        until lGLEntry.Next = 0;
                    Message(('Donne'));


                end;

            }


        }
        addfirst(Category_Category4)
        {
            actionref("Modifier champs extra-comp1"; "Modifier champs extra-comp")
            {
            }
            actionref("Ecritures abonnement1"; "Ecritures abonnement")
            {
            }
            actionref("Batch vendor1"; "Batch vendor")
            {
            }

        }
    }

    var
        Navigate: Page Navigate;
        BaseTVA: Decimal;

    trigger OnAfterGetRecord()
    var
        RecLLGEntry: Record "G/L Entry";
    begin
        BaseTVA := 0;

        RecLLGEntry.SetCurrentKey("Entry No.");
        RecLLGEntry.SetRange("Entry No.", 0, Rec."Entry No." - 1);

        if RecLLGEntry.FindLast() then begin
            RecLLGEntry.CalcFields("Base TVA");
            IF RecLLGEntry."Base TVA" <> 0 then
                BaseTVA := RecLLGEntry."Base TVA";
        end;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        // MESSAGE('supprimer');
    end;


}


