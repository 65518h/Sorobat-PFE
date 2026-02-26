TableExtension 50178 "Service Contract HeaderEXT" extends "Service Contract Header"
{
    fields
    {


        field(8003965; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job where("Job Type" = const(External),
                                       "IC Partner Code" = const());

            trigger OnValidate()
            var
                lJob: Record Job;
            begin
                //JOB_SERVICE
                if ("Job No." <> xRec."Job No.") and (xRec."Job No." <> '') then
                    TestField("Change Status", 0);
                //#6944
                //IF ServLedgEntriesExist THEN
                //  ERROR(TextService,FIELDCAPTION("Job No."));
                //#6944//
                if ContractLinesExist2 then begin
                    ServContractLine.SetRange("Contract Type", "Contract Type");
                    ServContractLine.SetRange("Contract No.", "Contract No.");
                    ServContractLine.FindFirst;
                    repeat
                        ServContractLine.Validate("Job No.", "Job No.");
                        ServContractLine.Modify;
                    until ServContractLine.Next = 0;
                end;

                if "Job No." <> '' then
                    if lJob.Get("Job No.") then begin
                        if "Bill-to Customer No." = '' then
                            Validate("Customer No.", lJob."Bill-to Customer No.");
                        "Responsibility Center" := lJob."Responsibility Center";
                        "Salesperson Code" := lJob."Salesperson Code";
                        Validate("Shortcut Dimension 1 Code", lJob."Global Dimension 1 Code");
                        Validate("Shortcut Dimension 2 Code", lJob."Global Dimension 2 Code");
                    end;
                //JOB_SERVICE//
            end;
        }
    }
    //GL2024 Créer une procédure copiée de la procédure standard (ContractLinesExist) car la procédure est locale dans la table Service Contract Header, et il est nécessaire de l'utiliser dans la tableEXT de cette table
    local procedure ContractLinesExist2() Result: Boolean
    begin
        ServContractLine.Reset();
        ServContractLine.SetRange("Contract Type", "Contract Type");
        ServContractLine.SetRange("Contract No.", "Contract No.");
        Result := ServContractLine.Find('-');
    end;
    //GL2024 FIN
    var
        Text038: label '%1 is not the same in %2 %3 and %4 %5.';
        Text039: label 'Do you want to update the %1 with %2 %3?';
        Text046: label 'Some of the existing lines belong to other service contracts and will be removed\\ Would you like to continue?';
        Text047: label 'It is not possible to change the status field because all the existing lines belong to other service contracts.';
        TextService: label 'You cannot change the %1 field because there are service entry lines for this contract.';
        ServContractLine: Record "Service Contract Line";
}

