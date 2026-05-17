table 50001 "Chef Chantier Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Paramètres Chef de Chantier';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Clé primaire';
        }
        field(2; "Backend URL"; Text[250])
        {
            Caption = 'URL du backend .NET';
            ToolTip = 'URL de base de l''API .NET. Ex : https://abc123.ngrok-free.app';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetSetup(): Record "Chef Chantier Setup"
    var
        Setup: Record "Chef Chantier Setup";
    begin
        if not Setup.Get('') then
            Error('Les paramètres Chef de Chantier ne sont pas configurés. Veuillez renseigner l''URL du backend.');

        if Setup."Backend URL" = '' then
            Error('L''URL du backend .NET n''est pas renseignée dans les paramètres Chef de Chantier.');

        exit(Setup);
    end;
}