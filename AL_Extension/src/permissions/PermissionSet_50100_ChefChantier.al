permissionset 50100 "Chef Chantier Access"
{
    Assignable = true;
    Caption = 'Chef Chantier Access';

    Permissions =
        tabledata "Chef Chantier" = RIMD,
        table "Chef Chantier" = X,
        page "ChefChantierAPI" = X,
        page "Chef Chantier List" = X;
}