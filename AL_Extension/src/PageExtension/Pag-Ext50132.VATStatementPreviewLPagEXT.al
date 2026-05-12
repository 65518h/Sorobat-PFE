PageExtension 50132 "VAT Statement Preview L_PagEXT" extends "VAT Statement Preview Line"
{

    layout
    {

        modify(ColumnValue)
        {
            Visible = false;

        }
        addafter(ColumnValue)
        {
            field(ColumnValue2; ColumnValue)
            {
                ApplicationArea = Basic, Suite;
                AutoFormatType = 1;
                //blankzero = true;
                Caption = 'Column Amount';
                DrillDown = true;
                ToolTip = 'Specifies the type of entries that will be included in the amounts in columns.';

                trigger OnDrillDown()
                begin
                    case Rec.Type of
                        Rec.Type::"Account Totaling":
                            begin
                                GLEntry.SetFilter("G/L Account No.", Rec."Account Totaling");
                                Rec.CopyFilter("Date Filter", GLEntry."VAT Reporting Date");


                                //BE_TVA
                                /*  CASE rec."Document Type" OF
                                      rec."Document Type"::"All except Credit Memo":
                                          GLEntry.SETFILTER("Document Type", '<>%1', rec."Document Type"::"Credit Memo");
                                      rec."Document Type"::None:
                                          GLEntry.SETRANGE("Document Type", rec."Document Type"::" ");
                                      rec."Document Type"::" ":
                                          BEGIN
                                          END;   //Tous les documents
                                      ELSE
                                          GLEntry.SETRANGE("Document Type", rec."Document Type");
                                  END;*/
                                //BE_TVA//






                                PAGE.Run(PAGE::"General Ledger Entries", GLEntry);
                            end;
                        Rec.Type::"VAT Entry Totaling":
                            begin
                                VATEntry.Reset();
                                SetKeyForVATEntry2(VATEntry);
                                VATEntry.SetRange(Type, Rec."Gen. Posting Type");
                                VATEntry.SetRange("VAT Bus. Posting Group", Rec."VAT Bus. Posting Group");
                                VATEntry.SetRange("VAT Prod. Posting Group", Rec."VAT Prod. Posting Group");
                                VATEntry.SetRange("Tax Jurisdiction Code", Rec."Tax Jurisdiction Code");
                                VATEntry.SetRange("Use Tax", Rec."Use Tax");
                                if Rec.GetFilter("Date Filter") <> '' then
                                    SetDateFilterForVATEntry2(VATEntry);

                                case Selection of
                                    Selection::Open:
                                        VATEntry.SetRange(Closed, false);
                                    Selection::Closed:
                                        VATEntry.SetRange(Closed, true);
                                    Selection::"Open and Closed":
                                        VATEntry.SetRange(Closed);
                                end;



                                //BE_TVA
                                /*    CASE rec."Document Type" OF
                                        rec."Document Type"::"All except Credit Memo":
                                            VATEntry.SETFILTER("Document Type", '<>%1', rec."Document Type"::"Credit Memo");
                                        rec."Document Type"::None:
                                            VATEntry.SETRANGE("Document Type", rec."Document Type"::" ");
                                        rec."Document Type"::" ":
                                            BEGIN
                                            END;   //Tous les documents
                                        ELSE
                                            VATEntry.SETRANGE("Document Type", rec."Document Type");
                                    END;*/
                                //BE_TVA//




                                PAGE.Run(PAGE::"VAT Entries", VATEntry);
                            end;
                        Rec.Type::"Row Totaling",
                        Rec.Type::Description:
                            Error(Text000, Rec.FieldCaption(Type), Rec.Type);
                    end;
                end;
            }
        }
    }


    actions
    {

    }

    procedure SetKeyForVATEntry2(var VATEntryLocal: Record "VAT Entry")
    begin
        if not VATEntryLocal.SetCurrentKey(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "VAT Reporting Date") then
            //BE_TVA
            // VATEntryLocal.SetCurrentKey(Type, Closed, "Tax Jurisdiction Code", "Use Tax", "VAT Reporting Date");
            VATEntry.SETCURRENTKEY(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Tax Jurisdiction Code", "Use Tax");
        //BE_TVA//
    end;

    procedure SetDateFilterForVATEntry2(var VATEntryLocal: Record "VAT Entry")
    begin
        if PeriodSelection = PeriodSelection::"Before and Within Period" then
            VATEntryLocal.SetRange("VAT Reporting Date", 0D, Rec.GetRangeMax("Date Filter"))
        else
            Rec.CopyFilter("Date Filter", VATEntryLocal."VAT Reporting Date");
    end;

    var
        Text000: Label 'Drilldown is not possible when %1 is %2.';
}

