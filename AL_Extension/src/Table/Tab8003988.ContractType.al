Table 8003988 "Contract Type"
{
    // //PROJET_FACT GESWAY 11/10/04 Table Type de contrat
    //               MB 01/03/07 Ajout des champs "Your Ref. Default Order Text","Initial Market Total","Market Total",
    //                           "Your Ref. Default Rider Text"
    // //PV ML 20/10/06 #3702 Ajout du champ "Interaction Template"
    // //COMMENT AC 12/02/07 Ajout deux nouveaux champs qui gèrent les commentaires en-tête ("Header Comment")
    //                       et les commentaires Pied ("Footer Comment")

    Caption = 'Contract Type';
    //   LookupPageID = 8003991;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Invoicing Method"; Option)
        {
            Caption = 'Invoicing Method';
            OptionCaption = 'Direct,Scheduler,Completion';
            OptionMembers = Direct,Scheduler,Completion;
        }
        field(4; "Sales Document Model"; Code[10])
        {
            Caption = 'Sales Document Model';
            TableRelation = "NaviBat Sales Doc. Model"."No." where("Document Type" = const("Sales Document"));
        }
        field(5; "Sales Posted Document Model"; Code[10])
        {
            Caption = 'Sales Posted Document Model';
            TableRelation = "Sales Document Setup"."Primary Key";
        }
        field(6; "Starting Text"; Code[10])
        {
            Caption = 'Starting Text';
            TableRelation = "Standard Text";
        }
        field(7; "Ending Text"; Code[10])
        {
            Caption = 'Ending Text';
            TableRelation = "Standard Text";
        }
        field(10; "Completion Posting Description"; Text[50])
        {
            Caption = 'Completion Posting Description';
        }
        field(11; "Scheduler Gen. Prod. Post. Gp"; Code[10])
        {
            Caption = 'Scheduler Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(12; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(13; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(14; "Interaction Template"; Code[10])
        {
            Caption = 'Modèle interaction';
            TableRelation = "Interaction Template";
        }
        field(15; "Header Comment Code"; Code[10])
        {
            Caption = 'Header Comment Code';
            TableRelation = "Standard Text";
        }
        field(16; "Footer Comment Code"; Code[10])
        {
            Caption = 'Footer Comment Code';
            TableRelation = "Standard Text";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure InsertSalesScheduler(pSalesHeader: Record "Sales Header")
    var
        lLine: Record "Contract Line";
        TextExist: label 'You must delete the existing scheduler lines before you can change %1.';
        lScheduler: Record "Invoice Scheduler";
        lContract: Record "Contract Type";
        lJob: Record Job;
    begin
        if (pSalesHeader."Document Type" > pSalesHeader."document type"::Order) or
          (pSalesHeader."Invoicing Method" <> pSalesHeader."invoicing method"::Scheduler) then
            exit;
        if pSalesHeader.wSchedulerLinesExist then
            Error(TextExist, pSalesHeader.FieldCaption("Contract Type"));

        lContract.Get(pSalesHeader."Contract Type");

        lLine.SetRange(lLine."Contract type", lContract.Code);
        if lLine.Find('-') then begin
            lScheduler.Init;
            lScheduler."Sales Header Doc. Type" := pSalesHeader."Document Type";
            lScheduler."Sales Header Doc. No." := pSalesHeader."No.";
            lScheduler.Validate("Job No.", pSalesHeader."Job No.");
            lScheduler."VAT Prod. Posting Group" := lContract."VAT Prod. Posting Group";
            lScheduler."AutoFormat Currency Code" := pSalesHeader."Currency Code";
            lScheduler."Payment Terms Code" := pSalesHeader."Payment Terms Code";
            lScheduler."Payment Method Code" := pSalesHeader."Payment Method Code";
            repeat
                lScheduler."Line No." := lLine."Line No.";
                lScheduler.Description := lLine.Description;
                lScheduler."Progress Degree" := lLine."Progress Degree";
                lScheduler.Validate("Document Percentage", lLine.Percentage);
                lScheduler.Insert(true);
            until lLine.Next = 0;
        end;
    end;
}

