echo "git pull"
git pull

#echo "./BEnotes_without_hashtag.sh"
#./BEnotes_without_hashtag.sh

yes '' | sed 3q
echo git diff
git diff

yes '' | sed 3q
echo "git add ."
git add .

yes '' | sed 3q
echo git status
git status
echo "press enter to continue"
read

yes '' | sed 3q
echo "git commit -m comment"
read -p "Enter git commit comment [local update of notes]: " COMMENT
COMMENT=${COMMENT:-local update of notes}
git commit -m "$COMMENT"

yes '' | sed 3q
echo git push
git push
