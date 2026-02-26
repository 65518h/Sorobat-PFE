TableExtension 50125 "Segment LineEXT" extends "Segment Line"
{
    fields
    {
        field(8001400; TableID; Integer)
        {
            Caption = 'Table ID';
        }
        field(8001401; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
    }

    procedure fCreateInteractionFromGuarante(pGuarantee: Record "Guarantee Entry"; pContact: Record Contact; pRequest: Boolean)
    var
        lInterTmpSetup: Record "Interaction Template Setup";
        lSalesHeader: Record "Sales Header";
        lInteracLogEntry: Record "Interaction Log Entry";
        tHandUp: label 'Guarantee Posted to %1';
        tRequest: label 'Guarantee Request to %1';
    begin
        //CAUTION
        //#5115
        DeleteAll;
        Init;
        Cont := pContact;
        if Cont.Type = Cont.Type::Person then
            SetRange("Contact Company No.", Cont."Company No.");
        SetRange("Contact No.", Cont."No.");
        Validate("Contact No.", Cont."No.");
        "Salesperson Code" := Cont."Salesperson Code";

        if lSalesHeader.Get(pGuarantee."Document Type", pGuarantee."No.") then
            "Salesperson Code" := lSalesHeader."Salesperson Code";
        if pRequest then
            Description := StrSubstNo(tRequest, Format(pGuarantee."Posting Date"))
        else
            Description := StrSubstNo(tHandUp, Format(pGuarantee."Closed Date"));
        "Document Type" := lInteracLogEntry.fSearchDocType(pGuarantee."Document Type", 0, 0);
        "Document No." := pGuarantee."No.";
        "Document Line No." := pGuarantee."Line No.";
        TableID := Database::"Guarantee Entry";
        "Send Word Doc. As Attmt." := true;

        lInterTmpSetup.Get;
        if pRequest then
            "Interaction Template Code" := lInterTmpSetup."Request Guarantee"
        else
            "Interaction Template Code" := lInterTmpSetup."Due Guarantee";

        StartWizard;
        //CAUTION//
    end;

    procedure fCreateInteractionFromSalesHea(pSalesHeader: Record "Sales Header"; pContact: Record Contact)
    var
        lInteracLogEntry: Record "Interaction Log Entry";
        tHandUp: label 'Guarantee Posted to %1';
        tRequest: label 'Guarantee Request to %1';
    begin
        //PROJET_ACTION
        //#5308
        DeleteAll;
        Init;
        Cont := pContact;
        if Cont.Type = Cont.Type::Person then
            SetRange("Contact Company No.", Cont."Company No.");
        SetRange("Contact No.", Cont."No.");
        Validate("Contact No.", Cont."No.");
        "Salesperson Code" := pSalesHeader."Salesperson Code";
        Validate(Date, WorkDate);
        "Document Type" := lInteracLogEntry.fSearchDocType(pSalesHeader."Document Type", 0, 0);
        "Document No." := pSalesHeader."No.";
        TableID := Database::"Sales Header";
        "Send Word Doc. As Attmt." := true;

        StartWizard;
        //PROJET_ACTION
    end;

    var
        Text011: label 'untitled';
        Text012: label 'You must fill in the %1 field.';
        Text020: label 'Your mail client has returned the following error.\';
        Todo: Record "To-do";
        Text021: label 'untitled';
        Text025: label 'Wizard Action field is not filled for selected interaction. \Blank Wizard Action does not enable interactions with hard copy or e-mail.';
        Text022: label 'You must fill in the %1 field.';
        Cont: Record Contact;
}

