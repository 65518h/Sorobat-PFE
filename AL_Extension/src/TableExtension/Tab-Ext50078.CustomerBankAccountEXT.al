TableExtension 50078 "Customer Bank AccountEXT" extends "Customer Bank Account"
{
    fields
    {


        field(50001; "Agency Code 2"; Text[5])
        {
            Caption = 'Agency Code';
            InitValue = '00000';

            trigger OnValidate()
            begin
                if StrLen("Agency Code") < 3 then
                    "Agency Code" := PadStr('', 3 - StrLen("Agency Code"), '0') + "Agency Code";
                "RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key");
            end;
        }
        field(50002; "RIB Key 2"; Integer)
        {
            Caption = 'RIB Key';

            trigger OnValidate()
            begin
                "RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key");
            end;
        }
        field(50003; "RIB Checked 2"; Boolean)
        {
            Caption = 'RIB Checked';
            Editable = false;
        }
        field(3010831; "Giro Account No."; Code[11])
        {
            Caption = 'Giro Account No.';

            trigger OnValidate()
            begin
                if "Giro Account No." = '' then
                    exit;

                //BankMgt.CheckPostAccountNo("Giro Account No.");
            end;
        }
        field(8004100; "Default Account"; Boolean)
        {
            Caption = 'Compte par défaut';

            trigger OnValidate()
            var
            //  lPaymentIntegration: Codeunit "Payment Integration";
            begin
                //+PMT+
                //IF gAddOnLicencePermission.HasPermissionPMT() THEN
                // lPaymentIntegration.CBABankAccOnValidate(Rec,xRec);
                //+PMT+//
            end;
        }
    }

    var
        //gAddOnLicencePermission: Codeunit IntegrManagement;
        RIBKey: Codeunit "RIB Key";
}

