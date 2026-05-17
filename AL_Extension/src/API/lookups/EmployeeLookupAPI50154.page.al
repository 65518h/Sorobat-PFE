page 50154 "EmployeeLookupAPI"
{
    PageType = API;
    Caption = 'employeeLookupApi';
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'employee';
    EntitySetName = 'employees';
    SourceTable = Employee;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { Editable = false; }
                field(matricule; Rec."No.") { }
                field(firstName; Rec."First Name") { }
                field(lastName; Rec."Last Name") { }
                field(fonction; Rec.Fonction) { }
                field(chantier; Rec.Chantier) { }
                
                // On utilise une variable qui contiendra le Base64
                field(imageBase64; GetImageAsBase64()) 
                { 
                    Caption = 'ImageBase64';
                }
            }
        }
    }

    procedure GetImageAsBase64(): Text
    var
        TenantMedia: Record "Tenant Media";
        InStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        // Vérifie si l'employé a une image (champ 140)
        if Rec.Image.HasValue then begin
            // On récupère le contenu binaire dans la table système Tenant Media
            if TenantMedia.Get(Rec.Image.MediaId) then begin
                TenantMedia.CalcFields(Content);
                if TenantMedia.Content.HasValue then begin
                    TenantMedia.Content.CreateInStream(InStream);
                    // On convertit le flux binaire en texte Base64
                    exit(Base64Convert.ToBase64(InStream));
                end;
            end;
        end;
        exit(''); // Retourne vide si pas d'image
    end;
}