Table 8001427 "Replication Setup"
{
    // //+REF+REPLIC CW 02/05/05 Setup replication

    Caption = 'Replication Setup';

    fields
    {
        field(1; "Key"; Integer)
        {
        }
        field(2; "Company Name"; Text[30])
        {
            Caption = 'Replicate from';
            TableRelation = Company.Name;

            trigger OnValidate()
            var
                lReplicationSetup: Record "Replication Setup";
                lReplicationTable: Record "Replication Table";
            begin
                if "Company Name" = '' then
                    exit;
                lTestCompanySetup("Company Name");
            end;
        }
        field(3; "Last Replication"; DateTime)
        {
            Caption = 'Last Replication';
        }
        field(4; Enable; Boolean)
        {
            Caption = 'Enable';
            InitValue = false;

            trigger OnValidate()
            var
                lReplicationLog: Record "Replication Log";
            begin
                if xRec.Enable and not lReplicationLog.IsEmpty then
                    Error(tErrorDisable);
            end;
        }
    }

    keys
    {
        key(Key1; "Key")
        {
            Clustered = true;
        }
        key(Key2; "Company Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lReplicationTable: Record "Replication Table";
    begin
        if Confirm(tConfirmDelete, false) then
            lReplicationTable.DeleteAll;
    end;

    var
        tConfirmDelete: label 'Do you want to delete réplication setup table list?';
        tErrorDisable: label 'Destroy the réplication log to disable this fonction.';

    local procedure lTestCompanySetup(pCompanyName: Text[30])
    var
        lReplicationSetup: Record "Replication Setup";
        tCompanyItSelf: label 'Replication can''t be from company itself.';
        tCompanyNotParam: label 'The compagny hasn''t the parameters to make replication';
    begin
        if pCompanyName = COMPANYNAME then
            Error(tCompanyItSelf);

        lReplicationSetup.ChangeCompany(pCompanyName);
        if not (lReplicationSetup.Get and lReplicationSetup.Enable and
                (lReplicationSetup."Company Name" = '')) then begin
            lReplicationSetup.TestField("Company Name", '');
            "Company Name" := xRec."Company Name";
            Error(tCompanyNotParam);
        end;
    end;
}

