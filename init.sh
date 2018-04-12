# initial operation for newly cloned repository

# instruct git not to touch the standalone_test.tex and seperated_pages.tex.
# these two files are changed from time to time and the changes of these two
# files should not be commited.
git update-index --skip-worktree standalone_test.tex
git update-index --skip-worktree separated_pages.tex
