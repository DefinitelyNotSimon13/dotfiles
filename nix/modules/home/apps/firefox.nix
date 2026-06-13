{ ... }:
{
  flake.modules.home.firefox = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        isDefault = true;
        name = "default";

        settings = {
          "extensions.autoDisableScopes" = 0;

          "extensions.activeThemeID" = "{b743f56d-1cc1-4048-8ba6-f9c2ab7aa54d}";
          "layout.css.prefers-color-scheme.content-override" = 0;

          "browser.download.useDownloadDir" = true;

          "privacy.donottrackheader.enabled" = true;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;

          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          "signon.generation.enabled" = false;
          "signon.management.page.breach-alerts.enabled" = false;

          "extensions.formautofill.creditCards.enabled" = false;
        };

        search = {
          force = true;
          default = "ddg";

          order = [
            "ddg"
            "nix-packages"
            "nixos-options"
            "hm-options"
            "github"
          ];

          engines = {
            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            nixos-options = {
              name = "NixOS Options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };

            hm-options = {
              name = "HomeManger Options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "source";
                      value = "home_manager";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@ho" ];
            };

            github = {
              name = "GitHub";
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                    {
                      name = "type";
                      value = "repositories";
                    }
                  ];
                }
              ];
              definedAliases = [ "@gh" ];
            };

            bing.metaData.hidden = true;
            amazon.metaData.hidden = true;
            ebay.metaData.hidden = true;
          };
        };

        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            dracula-dark-colorscheme
          ];
        };

        userChrome = ''
          #TabsToolbar {
            visibility: visible;
          }
        '';
      };

    };
  };
}
