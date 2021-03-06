[CCode (prefix = "", lower_case_cprefix = "", cheader_filename = "config.h")]
namespace Config
{
	/* Package information */
	public const string PACKAGE_NAME;
	public const string PACKAGE_STRING;
	public const string PACKAGE_VERSION;

	/* Gettext package */
	public const string GETTEXT_PACKAGE;

	/* Configured paths - these variables are not present in config.h, they are
	 * passed to underlying C code as cmd line macros. */
	public const string EVGLOCALEDIR;  /* /usr/local/share/locale  */
	public const string EVGDATADIR; /* /usr/local/share/evg-chess */
	public const string PKGLIBDIR;  /* /usr/local/lib/evg-chess   */
}
