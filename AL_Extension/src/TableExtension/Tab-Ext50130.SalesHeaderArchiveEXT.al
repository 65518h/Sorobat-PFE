TableExtension 50130 "Sales Header ArchiveEXT" extends "Sales Header Archive"
{
    fields
    {
        modify("Posting from Whse. Ref.")
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8001301; "Criteria 1"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99090';
            Caption = 'Criteria 1';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001301));
        }
        field(8001302; "Criteria 2"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99091';
            Caption = 'Criteria 2';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001302));
        }
        field(8001303; "Criteria 3"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99092';
            Caption = 'Criteria 3';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001303));
        }
        field(8001304; "Criteria 4"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99093';
            Caption = 'Criteria 4';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001304));
        }
        field(8001305; "Criteria 5"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99094';
            Caption = 'Criteria 5';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001305));
        }
        field(8001306; "Criteria 6"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99095';
            Caption = 'Criteria 6';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001306));
        }
        field(8001307; "Criteria 7"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99096';
            Caption = 'Criteria 7';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001307));
        }
        field(8001308; "Criteria 8"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99097';
            Caption = 'Criteria 8';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001308));
        }
        field(8001309; "Criteria 9"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99098';
            Caption = 'Criteria 9';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001309));
        }
        field(8001310; "Criteria 10"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99099';
            Caption = 'Criteria 10';
            TableRelation = Code.Code where("Table No" = const(8004160),
                                             "Field No" = const(8001310));
        }
        field(8001400; "Financial Document"; Boolean)
        {
            Caption = 'Financial Document';
        }
        field(8001401; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
            NotBlank = true;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8001402; "Doc. Creation Date"; Date)
        {
            Caption = 'Doc. Creation Date';
            Editable = false;
        }
        field(8001403; "Source Quote No."; Code[20])
        {
            Caption = 'Source Quote No.';
        }
        field(8001404; "Close Opportunity Code"; Code[10])
        {
            Caption = 'Close Opportunity Code';
            TableRelation = "Close Opportunity Code".Code;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
        }
        field(8001902; "Next Invoice Time"; DateFormula)
        {
            Caption = 'Next Invoice Time';
        }
        field(8001903; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
            Editable = false;
        }
        field(8001904; "Source Invoice No."; Code[20])
        {
            Caption = 'Source Invoice No.';
        }
        field(8003900; "Closing No."; Integer)
        {
            Caption = 'Closing No.';

            trigger OnValidate()
            var
                lText1100280001: label '%1 must be superior to %2.';
                lText1100280002: label 'This document will not be a completion %1 any more.\';
                lText1100280003: label 'You cannot create a completion %1.';
                lText1100280004: label 'Completion %1 cannot be at %2.';
            begin
            end;
        }
        field(8003901; "Scheduler Origin"; Boolean)
        {
            Caption = 'Scheduler Origin';
            Editable = false;
        }
        field(8003902; "Order Type"; Option)
        {
            Caption = 'Order Type';
            OptionCaption = ' ,Internal Order';
            OptionMembers = " ","Internal Order",Transfer;
        }
        field(8003903; "Rider to Order No."; Code[20])
        {
            Caption = 'Rider No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "Sell-to Customer No." = field("Sell-to Customer No."),
                                                        "Order Type" = const("Supply Order"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                lSalesHeader: Record "Sales Header";
            begin
            end;
        }
        field(8003905; Subject; Text[50])
        {
            Caption = 'Object';
        }
        field(8003906; "Invoicing Method"; Option)
        {
            Caption = 'Invoicing Method';
            OptionCaption = 'Direct,Scheduler,Completion';
            OptionMembers = Direct,Scheduler,Completion;
        }
        field(8003908; "Review Formula Code"; Code[10])
        {
            Caption = 'Price Index Code';
            TableRelation = Free8003984;
        }
        field(8003909; "Review Base Date"; Date)
        {
            Caption = 'Index Basis Date';
        }
        field(8003911; "Recognition Method"; Option)
        {
            Caption = 'Recognition Method';
            OptionCaption = 'Percentage of Completion,Completed Contract';
            OptionMembers = "Percentage of Completion","Completed Contract";
        }
        field(8003912; "Person Responsible"; Code[20])
        {
            ////CaptionClass = wGetCaptionNaviBat(8003912);
            Caption = 'Person Responsible';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal),
                                            "Search Name" = filter(<> ''));
        }
        field(8003913; "Project Manager"; Code[20])
        {
            Caption = 'Project Manager';
            TableRelation = Contact;
        }
        field(8003914; "Completely Invoiced"; Boolean)
        {
            Caption = 'Completely Invoiced';
            Editable = false;
        }
        field(8003915; "Amount Excl. VAT (LCY)"; Decimal)
        {
            CalcFormula = sum("Sales Line Archive"."Amount Excl. VAT (LCY)" where("Document Type" = field("Document Type"),
                                                                                   "Document No." = field("No."),
                                                                                   "Line Type" = filter(> Totaling),
                                                                                   "Structure Line No." = filter(0),
                                                                                   "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                                   "Version No." = field("Version No.")));
            Caption = 'Amount Excl. VAT (LCY)';
            FieldClass = FlowField;
        }
        field(8003916; "Ship-to Phone No."; Text[30])
        {
            Caption = 'Ship-to Phone No.';
        }
        field(8003917; "Ship-to Fax No."; Text[30])
        {
            Caption = 'Ship-to Fax No.';
        }
        field(8003918; "Source Quote Occurence No."; Integer)
        {
            Caption = 'Source Quote Occurence No.';
        }
        field(8003919; "Source Quote Version No."; Integer)
        {
            Caption = 'Source Quote Version No.';
        }
        field(8003920; "Sell-to Contact Company No."; Code[20])
        {
            Caption = 'Sell-to Contact Company No.';
            TableRelation = Contact where(Type = const(Company));
        }
        field(8003921; "Ship-to Contact No."; Code[20])
        {
            Caption = 'Ship-to Contact No.';
            TableRelation = Contact;
        }
        field(8003922; "Job Description"; Text[50])
        {
            Caption = 'Job Description';
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(8003924; "Part Payment"; Decimal)
        {
            //blankzero = true;
            Caption = 'Part Payment';
        }
        field(8003925; "Contract Type"; Code[10])
        {
            Caption = 'Contract Type';
            TableRelation = "Contract Type".Code;
        }
        field(8003927; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(8003947; "Person Responsible 2"; Code[20])
        {
            ////CaptionClass = wGetCaptionNaviBat(8003947);
            Caption = 'Person Responsible 2';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));
        }
        field(8003948; "Person Responsible 3"; Code[20])
        {
            ////CaptionClass = wGetCaptionNaviBat(8003948);
            Caption = 'Person Responsible 3';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));
        }
        field(8003949; "Person Responsible 4"; Code[20])
        {
            ////CaptionClass = wGetCaptionNaviBat(8003949);
            Caption = 'Person Responsible 4';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));
        }
        field(8003950; "Person Responsible 5"; Code[20])
        {
            ////CaptionClass = wGetCaptionNaviBat(8003950);
            Caption = 'Person Responsible 5';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));
        }
        field(8003966; "Free Date 1"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003966);
            Caption = 'Free Date 1';
        }
        field(8003967; "Free Date 2"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003967);
            Caption = 'Free Date 2';
        }
        field(8003968; "Free Date 3"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003968);
            Caption = 'Free Date 3';
        }
        field(8003969; "Free Date 4"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003969);
            Caption = 'Free Date 4';
        }
        field(8003970; "Free Date 5"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003970);
            Caption = 'Free Date 5';
        }
        field(8003971; "Free Date 6"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003971);
            Caption = 'Free Date 6';
        }
        field(8003972; "Free Date 7"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003972);
            Caption = 'Free Date 7';
        }
        field(8003973; "Free Date 8"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003973);
            Caption = 'Free Date 8';
        }
        field(8003974; "Free Date 9"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003974);
            Caption = 'Free Date 9';
        }
        field(8003975; "Free Date 10"; Date)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003975);
            Caption = 'Free Date 10';
        }
        field(8003976; "Free Value 1"; Decimal)
        {
            //blankzero = true;
            ////CaptionClass = wGetCaptionNaviBat(8003976);
            Caption = 'Free Value 1';
        }
        field(8003977; "Free Value 2"; Decimal)
        {
            //blankzero = true;
            ////CaptionClass = wGetCaptionNaviBat(8003977);
            Caption = 'Free Value 2';
        }
        field(8003978; "Free Value 3"; Decimal)
        {
            //blankzero = true;
            ////CaptionClass = wGetCaptionNaviBat(8003978);
            Caption = 'Free Value 3';
        }
        field(8003979; "Free Value 4"; Decimal)
        {
            //blankzero = true;
            ////CaptionClass = wGetCaptionNaviBat(8003979);
            Caption = 'Free Value 4';
        }
        field(8003980; "Free Value 5"; Decimal)
        {
            //blankzero = true;
            ////CaptionClass = wGetCaptionNaviBat(8003980);
            Caption = 'Free Value 5';
        }
        field(8003981; "Free Boolean 1"; Boolean)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003981);
            Caption = 'Free Boolean 1';
        }
        field(8003982; "Free Boolean 2"; Boolean)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003982);
            Caption = 'Free Boolean 2';
        }
        field(8003983; "Free Boolean 3"; Boolean)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003983);
            Caption = 'Free Boolean 3';
        }
        field(8003984; "Free Boolean 4"; Boolean)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003984);
            Caption = 'Free Boolean 4';
        }
        field(8003985; "Free Boolean 5"; Boolean)
        {
            ////CaptionClass = wGetCaptionNaviBat(8003985);
            Caption = 'Free Boolean 5';
        }
        field(8003986; "Progress Degree"; Code[10])
        {
            Caption = 'Progress Degree';
            TableRelation = "Document Progress Degree" where("Document Type" = field("Document Type"));

            trigger OnValidate()
            var
                lProgress: Record "Document Progress Degree";
            begin
            end;
        }
        field(8003988; "Job Starting Date"; Date)
        {
            Caption = 'Job Starting Date';
        }
        field(8003989; "Job Ending Date"; Date)
        {
            Caption = 'Job Ending Date';
        }
        field(8004050; "Deadline Code"; Code[10])
        {
            Caption = 'Deadline code';
            TableRelation = "Deadline Term";

            trigger OnValidate()
            var
                lDeadlineTerm: Record "Deadline Term";
            begin
            end;
        }
        field(8004051; "Deadline Date"; Date)
        {
            Caption = 'Deadline';
        }
    }
    keys
    {

        /*GL2024 key(STG_Key5;"Document Type","Order Type","No.")
         {
         }*/
        key(STG_Key6; "Job No.")
        {
        }

        key(STG_Key7; "Document Type", "Sell-to Contact No.")
        {
        }

        /* GL2024   key(STG_Key8;"Document Type","Sell-to Contact Company No.")
           {
           }

           key(STG_Key9;"Document Type","Order No.")
           {
           }*/
    }









    trigger OnAfterDelete()
    var
        lSalesContributor: Record "Sales Contributor Archive";
        lDescriptionLine: Record "Description Line Archive";
        lSalesOverheadMargin: Record "Sales Overhead-Margin Archive";
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //DEVIS
        IF ("Document Type" = "Document Type"::Quote) AND ("Order Type" = "Order Type"::" ") THEN BEGIN
            lSalesContributor.SETRANGE("Document Type", "Document Type");
            lSalesContributor.SETRANGE("Document No.", "No.");
            lSalesContributor.SETRANGE("Doc. No. Occurrence", "Doc. No. Occurrence");
            lSalesContributor.SETRANGE("Version No.", "Version No.");
            IF NOT lSalesContributor.ISEMPTY THEN
                lSalesContributor.DELETEALL(TRUE);
        END;

        lDescriptionLine.SETRANGE("Table ID", DATABASE::"Sales Header Archive");
        lDescriptionLine.SETRANGE("Document Type", "Document Type");
        lDescriptionLine.SETRANGE("Document No.", "No.");
        lDescriptionLine.SETRANGE("Document Line No.", 0);
        IF NOT lDescriptionLine.ISEMPTY THEN
            lDescriptionLine.DELETEALL;
        lDescriptionLine.RESET;
        lDescriptionLine.SETRANGE("Table ID", DATABASE::"Sales Line Archive");
        lDescriptionLine.SETRANGE("Document Type", "Document Type");
        lDescriptionLine.SETRANGE("Document No.", "No.");
        IF NOT lDescriptionLine.ISEMPTY THEN
            lDescriptionLine.DELETEALL;

        lSalesOverheadMargin.SETRANGE("Document Type", "Document Type");
        lSalesOverheadMargin.SETRANGE("Document No.", "No.");
        IF NOT lSalesOverheadMargin.ISEMPTY THEN
            lSalesOverheadMargin.DELETEALL;
        //DEVIS//

        //#7639
        lRecRef.GETTABLE(xRec);
        lBOQCustMgt.gOndelete(lRecRef, TRUE);
        //#7639//  
    end;


    procedure wGetCaptionNaviBat(pFieldNumber: Integer): Text[250]
    var
        lNaviBatSetup: Record NavibatSetup;
        lReturnText: Text[250];
    begin
        with lNaviBatSetup do begin
            GET2;
            case pFieldNumber of
                8003912:
                    if "Person Responsible Name 1" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 1"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible");
                8003947:
                    if "Person Responsible Name 2" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 2"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible 2");
                8003948:
                    if "Person Responsible Name 3" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 3"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible 3");
                8003949:
                    if "Person Responsible Name 4" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 4"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible 4");
                8003950:
                    if "Person Responsible Name 5" <> '' then
                        lReturnText := '1,5,,' + "Person Responsible Name 5"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Person Responsible 5");
                /*
                     8003956:
                      IF "Free Field Name 1" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 1"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 1");
                     8003957:
                      IF "Free Field Name 2" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 2"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 2");
                     8003958:
                      IF "Free Field Name 3" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 3"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 3");
                     8003959:
                      IF "Free Field Name 4" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 4"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 4");
                     8003960:
                      IF "Free Field Name 5" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 5"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 5");
                     8003961:
                      IF "Free Field Name 6" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 6"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 6");
                     8003962:
                      IF "Free Field Name 7" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 7"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 7");
                     8003963:
                      IF "Free Field Name 8" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 8"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 8");
                     8003964:
                      IF "Free Field Name 9" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 9"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 9");
                     8003965:
                      IF "Free Field Name 10" <> '' THEN
                        lReturnText := '1,5,,'+ "Free Field Name 10"
                      ELSE
                        lReturnText := '1,5,,'+ Rec.FIELDCAPTION("Free Field 10");
                */
                8003966:
                    if "Free Date Name 1" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 1"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 1");
                8003967:
                    if "Free Date Name 2" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 2"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 2");
                8003968:
                    if "Free Date Name 3" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 3"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 3");
                8003969:
                    if "Free Date Name 4" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 4"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 4");
                8003970:
                    if "Free Date Name 5" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 5"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 5");
                8003971:
                    if "Free Date Name 6" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 6"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 6");
                8003972:
                    if "Free Date Name 7" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 7"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 7");
                8003973:
                    if "Free Date Name 8" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 8"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 8");
                8003974:
                    if "Free Date Name 9" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 9"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 9");
                8003975:
                    if "Free Date Name 10" <> '' then
                        lReturnText := '1,5,,' + "Free Date Name 10"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Date 10");
                8003976:
                    if "Free Value Name 1" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 1"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 1");
                8003977:
                    if "Free Value Name 2" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 2"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 2");
                8003978:
                    if "Free Value Name 3" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 3"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 3");
                8003979:
                    if "Free Value Name 4" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 4"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 4");
                8003980:
                    if "Free Value Name 5" <> '' then
                        lReturnText := '1,5,,' + "Free Value Name 5"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Value 5");
                8003981:
                    if "Free Boolean Name 1" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 1"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 1");
                8003982:
                    if "Free Boolean Name 2" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 2"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 2");
                8003983:
                    if "Free Boolean Name 3" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 3"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 3");
                8003984:
                    if "Free Boolean Name 4" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 4"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 4");
                8003985:
                    if "Free Boolean Name 5" <> '' then
                        lReturnText := '1,5,,' + "Free Boolean Name 5"
                    else
                        lReturnText := '1,5,,' + Rec.FieldCaption("Free Boolean 5");
            end;
            exit(lReturnText);
        end;

    end;

    procedure wSynchro(pCurrFieldNo: Integer; pCaption: Text[50])
    var
        lJob: Record Job;
        lRecRefSales: RecordRef;
        lFieldRefSales: FieldRef;
        lFieldRefSalesType: FieldRef;
        lFieldRefSalesNo: FieldRef;
        lRecRefJob: RecordRef;
        lFieldRefJob: FieldRef;
        lFieldRefJobNo: FieldRef;
        lCurrFieldNoJob: Integer;
        lValue: Text[50];
    begin
        if lJob.Get("Job No.") then begin
            if pCurrFieldNo = 8003912 then
                lCurrFieldNoJob := 20
            else
                lCurrFieldNoJob := pCurrFieldNo;
            lRecRefSales.GetTable(Rec);
            lFieldRefSales := lRecRefSales.Field(pCurrFieldNo);
            lRecRefJob.GetTable(lJob);
            lFieldRefJob := lRecRefJob.Field(lCurrFieldNoJob);
            lFieldRefJobNo := lRecRefJob.Field(1);
            Evaluate(lValue, Format(lFieldRefJob.Value));
            if (lFieldRefSales.Value <> lFieldRefJob.Value) and
               (lValue <> '') then
                if not Confirm(TextSynchro, true, pCaption,
                                                lFieldRefJob.Value,
                                                lFieldRefSales.Value,
                                                lFieldRefJobNo.Value, '') then
                    exit;
            lFieldRefJob.Value(lFieldRefSales.Value);
            lRecRefJob := lFieldRefJob.Record;
            lRecRefJob.Modify;
        end;
    end;

    local procedure lGetCaptionsStatsExplorer(pFieldID: Integer): Text[250]
    var
        lStatisticAggregate: Record "Statistic aggregate";
    begin
        if lStatisticAggregate.ReadPermission then
            exit(lStatisticAggregate.GetCaptionsStatsExplorer(pFieldID))
        else
            exit('');
    end;


    var

        Text8003902: label 'Do you want to archive the quote?';
        Text8003903: label 'You must choose the loss reason.';
        wStatisticAggregate: Record "Statistic aggregate";
        TextSynchro: label 'Do you want to replace %1 %2 by %3 in %4 %5?';
}

