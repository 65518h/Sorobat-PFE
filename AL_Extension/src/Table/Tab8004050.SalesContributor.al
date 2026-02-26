Table 8004050 "Sales Contributor"
{
    // //DEVIS GESWAY 07/11/02 Nouvelle table des intervenants d'un document vente
    //                09/12/03 Init champ Responsability -> OnValidate(Contributor)
    // //PROJET_ACTION 16/12/03 Ajout fonction wCreateInteraction
    // //CRM GESWAY 11/02/04 Ajout champs "Contact Company No."

    Caption = 'Sales Contributor';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));

            trigger OnValidate()
            var
                lSalesHeader: Record "Sales Header";
            begin
                if lSalesHeader.Get("Document Type", "Document No.") and ("Job No." = '') then
                    "Job No." := lSalesHeader."Job No.";
            end;
        }
        field(5; Contributor; Code[20])
        {
            Caption = 'Contributor';
            TableRelation = Code.Code where("Table No" = const(8004050),
                                             "Field No" = const(5));

            trigger OnValidate()
            begin
                Code.SetRange("Table No", 8004050);
                Code.SetRange("Field No", 5);
                Code.SetRange(Code, Contributor);
                if Code.FindFirst then
                    Responsability := Code.Description
                else
                    Responsability := '';
            end;
        }
        field(6; Responsability; Text[30])
        {
            Caption = 'Job Responsibility';
            FieldClass = Normal;
        }
        field(10; "Contact Type"; Option)
        {
            Caption = 'Contact Type';
            FieldClass = Normal;
            OptionCaption = 'Company,Person';
            OptionMembers = Company,Person;

            trigger OnValidate()
            begin
                if "Contact Type" <> xRec."Contact Type" then
                    Validate("Contact No.", '');
            end;
        }
        field(11; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = if ("Contact Type" = const(Company)) Contact."No." where(Type = const(Company))
            else
            if ("Contact Type" = const(Person)) Contact."No." where(Type = const(Person));

            trigger OnValidate()
            begin
                if "Contact No." <> '' then begin
                    Contact.Get("Contact No.");
                    case Contact.Type of
                        Contact.Type::Company:
                            "Contact Company Name" := Contact.Name;
                        Contact.Type::Person:
                            begin
                                "Contact Type" := Contact.Type;
                                "Contact Company Name" := Contact."Company Name";
                                "Contact Name" := Contact.Name;
                            end;
                    end;
                    "Contact City" := Contact.City;
                    "Contact Phone No." := Contact."Phone No.";
                end else begin
                    Clear("Contact Company Name");
                    Clear("Contact Name");
                    Clear("Contact City");
                    Clear("Contact Phone No.");
                    Clear("Contact Company No.");
                end;

                wUpdateContactCompanyNo;
            end;
        }
        field(12; "Contact Company Name"; Text[50])
        {
            Caption = 'Company Name';
            Editable = false;
        }
        field(13; "Contact Name"; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(14; "Contact City"; Text[30])
        {
            Caption = 'City';
            Editable = false;
        }
        field(15; "Contact Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
        }
        field(16; "Job No."; Code[20])
        {
            Caption = 'N° Affaire';
            TableRelation = Job;
        }
        field(17; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(18; "Contact Company No."; Code[20])
        {
            Caption = 'Sell-to Contact Company No.';
            TableRelation = Contact where(Type = const(Company));

            trigger OnValidate()
            var
                Opp: Record Opportunity;
                OppEntry: Record "Opportunity Entry";
                Todo: Record "To-do";
                InteractLogEntry: Record "Interaction Log Entry";
                SegLine: Record "Segment Line";
                SalesHeader: Record "Sales Header";
            begin
            end;
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Job No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", Contributor)
        {
        }
        key(Key3; "Job No.")
        {
        }
        key(Key4; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Line No." = 0 then begin
            Contributor2.SetRange("Document Type", "Document Type");
            Contributor2.SetRange("Document No.", "Document No.");
            Contributor2.SetRange("Job No.", "Job No.");
            if Contributor2.Find('+') then
                "Line No." := Contributor2."Line No." + 10000
            else
                "Line No." := 10000;
        end;
    end;

    var
        Contact: Record Contact;
        Contributor2: Record "Sales Contributor";
        "Code": Record "Code";


    procedure wCreateInteraction(pSalesHeader: Record "Sales Header"; pContact: Option SellToCust,BillToCust,ProjectManager,SalesContributor)
    var
        lInteracLogEntry: Record "Interaction Log Entry";
        lSegLine: Record "Segment Line" temporary;
        lContact: Record Contact;
        lCreateInteraction: Page "Create Interaction";
        TempTodo: Record "To-do" temporary;
    begin
        //PROJET_ACTION
        case pContact of
            0:
                begin
                    pSalesHeader.TestField("Sell-to Contact No.");
                    lContact.Get(pSalesHeader."Sell-to Contact No.");
                end;
            1:
                begin
                    pSalesHeader.TestField("Bill-to Contact No.");
                    lContact.Get(pSalesHeader."Bill-to Contact No.");
                end;
            2:
                begin
                    pSalesHeader.TestField("Project Manager");
                    lContact.Get(pSalesHeader."Project Manager");
                end;
            3:
                begin
                    TestField("Contact No.");
                    lContact.Get("Contact No.");
                end;
        end;

        lSegLine.fCreateInteractionFromSalesHea(pSalesHeader, lContact);
        //?? TempTodo.fCreateToDoFromSalesHeader(pSalesHeader,lContact);
        //PROJET_ACTION//
    end;


    procedure wUpdateContactCompanyNo()
    var
        lContact: Record Contact;
    begin
        //CRM
        if "Contact No." <> '' then begin
            lContact.Get("Contact No.");
            if lContact."Company No." <> '' then
                "Contact Company No." := lContact."Company No."
            else
                "Contact Company No." := "Contact No.";
        end;
        //CRM//
    end;


    procedure wSendNewEmail(pSalesHeader: Record "Sales Header"; pContact: Option SellToCust,BillToCust,ProjectManager,SalesContributor)
    var
        lContact: Record Contact;
        lCreateInteraction: Page "Create Interaction";
        lSelPrint: Record "Printer Selection";
        lCustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        lDocPrint: Codeunit "Document-Print";
        lTextPdf: label 'You didn''t setup your PDF printer on Report 8001432.';
        lSingleIns: Codeunit "Import SingleInstance2";
    begin
        //PROJET_ACTION
        case pContact of
            0:
                begin
                    pSalesHeader.TestField("Sell-to Contact No.");
                    lContact.Get(pSalesHeader."Sell-to Contact No.");
                end;
            1:
                begin
                    pSalesHeader.TestField("Bill-to Contact No.");
                    lContact.Get(pSalesHeader."Bill-to Contact No.");
                end;
            2:
                begin
                    pSalesHeader.TestField("Project Manager");
                    lContact.Get(pSalesHeader."Project Manager");
                end;
            3:
                begin
                    TestField("Contact No.");
                    lContact.Get("Contact No.");
                end;
        end;

        lContact.TestField("E-Mail");

        lSelPrint.SetRange("Report ID", 8001432);
        lSelPrint.SetFilter("User ID", '%1|%2', UserId, '');
        if lSelPrint.FindFirst then begin
            lSingleIns.SetInit(true);
            lSingleIns.SetContact(lContact);
            lCustCheckCreditLimit.SalesHeaderCheck(pSalesHeader);
            lDocPrint.PrintSalesHeader(pSalesHeader);
            lSingleIns.SetInit(false);
            lContact."No." := '';
            Clear(lContact);
            lSingleIns.SetContact(lContact);
        end
        else
            Message(lTextPdf);
    end;
}

