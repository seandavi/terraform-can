#!Rscript
main = function() {
    args = commandArgs(trailingOnly=TRUE)
    book_repo = args[1]
    book_path = args[2]
    pkg_repo = args[3]
    require(CollaborativeBookdown)
    buildSingleRepoBook(book_repo, book_path, pkg_repo)
}

main()
